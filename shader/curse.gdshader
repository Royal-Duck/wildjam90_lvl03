shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

float contrast(float x) {
	return ((abs(x) / x) + x) / 2.0;
}

void fragment() {
	COLOR = texture(screen_texture, UV);
	COLOR.g = contrast(COLOR.g - 0.5) + 0.5;
	COLOR.r = contrast(COLOR.r - 0.5) + 0.5;
	COLOR.b = contrast(COLOR.b - 0.5) + 0.5;
}