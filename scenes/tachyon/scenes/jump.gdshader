shader_type canvas_item;
render_mode unshaded;

uniform float shake_power = 0.03;
uniform float shake_speed = 5.0;
uniform float shake_block_size = 30.5;
uniform float shake_color_rate : hint_range(0.0, 1.0) = 0.01;

float random(float seed) {
    return fract(543.2543 * sin(dot(vec2(seed, seed), vec2(3525.46, -54.3415))));
}

void fragment() {
    vec2 uv = UV;

    // Glitch shift
    uv.x += (random((trunc(uv.y * shake_block_size) / shake_block_size) + TIME) - 0.5)
            * shake_power;

    // Base texture
    vec4 base_color = texture(TEXTURE, uv);

    // RGB color shift
    float r = texture(TEXTURE, uv + vec2(shake_color_rate, 0.0)).r;
    float b = texture(TEXTURE, uv - vec2(shake_color_rate, 0.0)).b;
    base_color.r = mix(base_color.r, r, 1.0);
    base_color.b = mix(base_color.b, b, 1.0);

    COLOR = base_color;
}
