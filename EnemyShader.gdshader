shader_type canvas_item;

uniform bool hit;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR += vec4(vec3(float(hit) * 0.8), COLOR.a);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
