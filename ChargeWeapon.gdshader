shader_type canvas_item;

uniform float charge : hint_range(0.0, 1.0);
uniform vec4 color : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (UV.x > charge) {
		COLOR.xyz += color.xyz;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
