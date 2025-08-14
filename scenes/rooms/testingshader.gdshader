shader_type canvas_item;
render_mode unshaded, skip_vertex_transform;

// ===== CRT Effect =====
const float curvature = 250.0; // Slightly more bend than 300, but still fullscreen-safe
const float vignette_multiplier = 1.5;

// ===== Toggles =====
uniform bool glitch_enabled = false; // Toggle from code
uniform bool crt_enabled = true;

// ===== Glitch Settings =====
uniform float shake_power = 0.03;
uniform float shake_rate : hint_range(0.0, 1.0) = 0.2;
uniform float shake_speed = 5.0;
uniform float shake_block_size = 30.5;
uniform float shake_color_rate : hint_range(0.0, 1.0) = 0.01;

// Screen texture
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

// Helper for glitch
float random(float seed) {
    return fract(543.2543 * sin(dot(vec2(seed, seed), vec2(3525.46, -54.3415))));
}

void fragment() {
    vec2 uv = SCREEN_UV;

    // ===== CRT warping =====
    vec3 cutoff = vec3(1.0);
    vec3 scanlines = vec3(1.0);
    vec3 vignette = vec3(0.0);
    if (crt_enabled) {
        vec2 centered_uv = uv * 2.0 - 1.0;
        vec2 uv_offset = centered_uv.yx / curvature; // Division means higher curvature = flatter
        vec2 warped_uv = centered_uv + centered_uv * uv_offset * uv_offset;
        cutoff = vec3(step(abs(warped_uv.x), 1.0) * step(abs(warped_uv.y), 1.0));
        scanlines = vec3(sin(2.0 * warped_uv.y * 180.0) * 0.1 + 0.9);
        vignette = vec3(length(pow(abs(centered_uv), vec2(4.0)) / 3.0));
        uv = (warped_uv + 1.0) / 2.0;
    }

    // ===== Glitch shifting =====
    float enable_shift = glitch_enabled ? float(random(trunc(TIME * shake_speed)) < shake_rate) : 0.0;
    uv.x += (
        random((trunc(uv.y * shake_block_size) / shake_block_size) + TIME) - 0.5
    ) * shake_power * enable_shift;

    // Sample the screen texture
    vec4 pixel_color = textureLod(screen_texture, uv, 0.2) * vec4(cutoff * scanlines, 1.0);

    // RGB color shift when glitching
    pixel_color.r = mix(
        pixel_color.r,
        textureLod(screen_texture, uv + vec2(shake_color_rate, 0.0), 0.0).r,
        enable_shift
    );
    pixel_color.b = mix(
        pixel_color.b,
        textureLod(screen_texture, uv + vec2(-shake_color_rate, 0.0), 0.0).b,
        enable_shift
    );

    // Apply vignette if CRT is on
    if (crt_enabled) {
        pixel_color.rgb -= vignette * vignette_multiplier;
    }

    COLOR = pixel_color;
}
