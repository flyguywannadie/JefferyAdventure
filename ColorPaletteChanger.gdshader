shader_type canvas_item;

uniform float angle: hint_range(0.0, 359.999, 0.1);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 col = texture(TEXTURE, UV);
	
	float xmax = max(max(col.r, col.g), col.b); // Maximum value
	float xmin = min(min(col.r, col.g), col.b); // Minimum value
	//float L = max(min(col.r, col.g), min(col.r, col.b)); // light value aka Mid value
	float C2 = xmax - xmin; // chroma or range
	//float C2 = 2.0 * (xmax - L); 
	
	float H = 0.0;
	
	if (xmax == col.r) {
		H = 60.0 * (mod((col.g - col.b)/C2, 6.0));
	} else if (xmax == col.g) {
		H = 60.0 * (((col.b - col.r)/C2) + 2.0);
	} else if (xmax == col.b) {
		H = 60.0 * (((col.r - col.g)/C2) + 4.0);
	} 
	
	float H2 = mod(H + angle, 360.0) / 60.0;
	float Sv;
	if (xmax == 0.0) {
		Sv = 0.0;
	} else {
		Sv = C2 / xmax;
	}
	//float Sl;
	//if (L == 0.0 || L == 1.0) {
		//Sl = 0.0;
	//} else {
		//Sl = (xmax - L)/(min(L, 1.0 - L));
	//}
	float C = xmax * Sv;
	//float C = (1.0 - abs((2.0 * L) - 1.0)) * Sl;
	float X = C * (1.0 - abs(mod(H2, 2.0) - 1.0));
	
	
	if (0.0 <= H2 && H2 < 1.0) {
		col.rgb = vec3(C, X, 0);
	} else if (1.0 <= H2 && H2 < 2.0) {
		col.rgb = vec3(X, C, 0);
	} else if (2.0 <= H2 && H2 < 3.0) {
		col.rgb = vec3(0, C, X);
	} else if (3.0 <= H2 && H2 < 4.0) {
		col.rgb = vec3(0, X, C);
	} else if (4.0 <= H2 && H2 < 5.0) {
		col.rgb = vec3(X, 0, C);
	} else if (5.0 <= H2 && H2 < 6.0) {
		col.rgb = vec3(C, 0, X);
	}
	
	float m = xmax - C;
	col.rgb = vec3(col.r + m, col.g + m, col.b + m);
	
	COLOR = col;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
