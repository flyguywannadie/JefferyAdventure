shader_type canvas_item;

uniform vec3 startPos;
uniform vec3 camPos;

void vertex() {
	vec3 a = vec3(VERTEX.xy, startPos.z);
	vec3 c = camPos;

	vec3 d = a-c;

	vec2 b;
	b.x = ((a.z/d.z)*d.x) + a.x;
	b.y = ((a.z/d.z)*d.y) + a.y;

	VERTEX = b;
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
