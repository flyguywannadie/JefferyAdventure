shader_type canvas_item;

uniform float size : hint_range(0.0, 3.0) = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX *= vec2((size * 0.25) + 1.0);
	//COLOR = vec4(VERTEX, 0.0, 1.0);
}

void fragment() {

	
	//float xOffset = UV.y * 0.25;
	//float t = cos((UV.x + xOffset + (TIME * 0.2)) * TAU * 5.0) * 0.5 + 0.5;

	//COLOR *= t;// vec4(max(COLOR.rgb, vec3(t)),COLOR.a);

	//if (COLOR.a > 0.95) {
		//vec3 outlineColor = vec3(207.0, 172.0, 80.0);
//
		//float test = abs(cos(TIME) * 1.0);//float(false);
//
		//COLOR = vec4(outlineColor,test);
	//}


	//vec2 uvsCentered = UV * 2.0 - 1.0;
	//float radialDistance = length(uvsCentered);

	//float wave = cos((radialDistance - abs(cos(TIME)) * 0.2) * TAU * 5.0) * 2.0 - 1.0;// * 0.5 + 0.5;
	//COLOR *= vec4(wave);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
