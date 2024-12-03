shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform bool active;

vec4 Invert(vec4 base, vec4 blend){
	return vec4(1.0-base.r, 1.0-base.g, 1.0-base.b, blend.a);
}

void vertex() {
}

void fragment() {
	if (active) {
		vec4 screenColor = texture(SCREEN_TEXTURE, SCREEN_UV);
		vec4 Color = texture(TEXTURE, UV);
		COLOR = Invert(screenColor, Color);
	}
}
