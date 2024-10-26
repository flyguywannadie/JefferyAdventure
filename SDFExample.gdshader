shader_type canvas_item;

void vertex() {
	UV = (UV * 2.0) - 1.0;
}

void fragment() {
	float dist = length(UV) - 0.3;
	
	//dist = step(0.0, dist); // makes a hard edge kinda I don't fully understand it
	
	COLOR = vec4(vec3(dist), 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
