shader_type canvas_item;

uniform vec2 size;

void vertex() {
	UV = UV * 2.0 - 1.0;
}

void fragment() {
	//float dist = length(UV) - 0.3;
	
	// https://iquilezles.org/articles/distfunctions2d/
	vec2 d = abs(UV) - size;
	float dist = length(max(d,0.0)) + min(max(d.x,d.y),0.0);
	
	dist = step(dist, 0.0); // makes a hard edge kinda I don't fully understand it
	
	COLOR = vec4(vec3(dist), 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
