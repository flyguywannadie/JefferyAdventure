shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 col = texture(TEXTURE, UV);
	//float test = cos((TIME * PI) / 360.0) * 0.5 + 0.5;
	float H = ((fract(UV.x + (TIME/3.0))) * 360.0) / 60.0;
	float C = 1.0;
	float X = C * (1.0 - abs(mod(H, 2.0) - 1.0));
	
	
	if (0.0 <= H && H < 1.0) {
		col.rgb = vec3(C, X, 0);
	} else if (1.0 <= H && H < 2.0) {
		col.rgb = vec3(X, C, 0);
	} else if (2.0 <= H && H < 3.0) {
		col.rgb = vec3(0, C, X);
	} else if (3.0 <= H && H < 4.0) {
		col.rgb = vec3(0, X, C);
	} else if (4.0 <= H && H < 5.0) {
		col.rgb = vec3(X, 0, C);
	} else {
		col.rgb = vec3(C, 0, X);
	}
	
	float m = 1.0 - C;
	col.rgb = vec3(col.r + m, col.g + m, col.b + m);
	
	//col.r = test/360.0;
	//col.g = mix(0.0, 1.0, (UV.x * 2.0) - 1.0);
	//col.b = mix(1.0, 0.0, UV.x);
	//col.a = 0.25;
	
	COLOR.rgb += col.rgb;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
