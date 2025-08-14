shader_type canvas_item;

uniform vec2 player_pos;
uniform float radius : hint_range(0.0, 1000.0) = 200.0;
uniform float softness : hint_range(0.0, 200.0) = 50.0;

// Manually set window size here:
const vec2 SCREEN_SIZE = vec2(72.0, 12.0);

void fragment() {
    float dist = distance(UV * SCREEN_SIZE, player_pos);
    float alpha = smoothstep(radius, radius - softness, dist);
    COLOR = vec4(0.0, 0.0, 0.0, alpha);
}
