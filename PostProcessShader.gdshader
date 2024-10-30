shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	//vec4 col = texture(screen_texture, UV + vec2(SCREEN_PIXEL_SIZE) * 2.0) * 0.15;
	//
	//col +=  texture(screen_texture, UV + vec2(SCREEN_PIXEL_SIZE)) * 0.12;
	//
	//COLOR = col;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
