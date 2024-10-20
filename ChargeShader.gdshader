shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	//float xOffset = UV.y * 0.25;
	//float t = cos((UV.x + xOffset + (TIME * 0.2)) * TAU * 5.0) * 0.5 + 0.5;
	
	//COLOR *= t;// vec4(max(COLOR.rgb, vec3(t)),COLOR.a);
	
	vec2 uvsCentered = UV * 2.0 - 1.0;
	float radialDistance = length(uvsCentered);
	
	float wave = cos((radialDistance - TIME * 0.5) * TAU * 5.0) * 0.5 + 0.5;
	COLOR = vec4(max(COLOR.xyz, vec3(wave)), COLOR.a);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
