shader_type canvas_item;

uniform float fade  : hint_range(0.0, 1.0);

void vertex() {
	COLOR.a = fade;
}

void fragment() {
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
