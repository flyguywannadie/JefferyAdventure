shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform vec4 colorTint : source_color;

uniform bool colorSprites = false;

vec3 rotateX(vec3 input, float angle){
	vec3 r = input;
	
	r.r = (r.r * 1.0) + 0.0 + 0.0;
	r.g = 0.0 + (r.g * cos(angle)) - (r.g * sin(angle));
	r.b = 0.0 + (r.b * sin(angle)) + (r.b * cos(angle));
	
	return r;
}

vec3 rotateY(vec3 input, float angle){
	vec3 r = input;
	
	r.r = (r.r * cos(angle)) + 0.0 + (r.r * sin(angle));
	r.g = 0.0 + (r.g * 1.0) + 0.0;
	r.b = -(r.b * sin(angle)) + 0.0 + (r.b * cos(angle));
	
	return r;
}

vec3 rotateZ(vec3 input, float angle){
	vec3 r = input;
	
	r.r = (r.r * cos(angle)) - (r.r * sin(angle)) + 0.0;
	r.g = (r.g * sin(angle)) + (r.g * cos(angle)) + 0.0;
	r.b = 0.0 + 0.0 + (r.b * 1.0);
	
	return r;
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	//vec4 col = texture(screen_texture, UV + vec2(SCREEN_PIXEL_SIZE) * 2.0) * 0.15;
	//
	//col +=  texture(screen_texture, UV + vec2(SCREEN_PIXEL_SIZE)) * 0.12;
	//
	//COLOR = col;
	
	vec4 col = texture(screen_texture, SCREEN_UV);
	
	// maybe replace this with a normal color tinting function
	vec4 ct = colorTint;
	
	if (colorSprites || !(col.r == col.g && col.r == col.b)) {
		col.rgb = rotateX(col.rgb, ct.r);
		col.rgb = rotateY(col.rgb, ct.g);
		col.rgb = rotateZ(col.rgb, ct.b);
	}
	
	COLOR = col;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
