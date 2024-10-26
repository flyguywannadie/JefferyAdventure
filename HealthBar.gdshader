shader_type canvas_item;

uniform float fill : hint_range(0.0, 1.0) = 0;
uniform float borderSize: hint_range(0.0, 1.0) = 0.3;
uniform sampler2D Test;

void vertex() {
	// Called for every vertex the material is visible on.
}

float InverseLerp(float a, float b, float c){
	return (c-a)/(b-a);
}

//render_mode blend_disabled; // DISABLE
//render_mode blend_add; // ADD
//render_mode blend_sub; // SUBTRACT
//render_mode blend_mix; // MIX
//render_mode blend_mul; // MULTIPLY
//render_mode blend_premul_alpha; // ALPHA

void fragment() {
	// Called for every pixel the material is visible on.
	
	// rounded corner clipping
	vec2 coords = UV;
	coords.x *= 5.0;
	
	vec2 pointOnLineSeg = vec2(clamp(coords.x, 0.5, 4.5), 0.5);
	float sdf = distance(coords, pointOnLineSeg) * 2.0 - 1.0;
	
	if (sdf > 0.0) {
		discard;
	}
	
	float borderSDF = sdf + borderSize;
	
	float pd = fwidth(borderSDF);
	
	float borderMask = 1.0 - clamp(borderSDF / pd, 0.0, 1.0);
	
	
	float healthbarMask = float(fill > UV.x); //floor(UV.x * 8.0)/8.0); can be used to break it into segments
	//if (healthbarMask < 0.1) {
		//discard;
	//}
	
	// float thealthcolor = clamp(InverseLerp(0.2, 0.8, fill), 0.0, 1.0); // T value of the healthbar color lerp
	// vec3 healthbarColor = mix(vec3(1,0,0),vec3(0,1,0),thealthcolor); // mix = lerp. and lerp between healthbar colors
	
	vec3 healthbarTextureColor = texture(Test, vec2(fill,UV.y)).rgb;
	
	if (fill < 0.5) {
		float flash = cos(TIME * (2.0/fill)) * 0.2 + 1.0;
		healthbarTextureColor *= flash;
	}
	
	//vec3 backgroundColor = vec3(0); // color of the background
	//vec3 outColor = mix(backgroundColor, healthbarColor, healthbarMask); // healthbar mask will only ever equal 0 or 1, so can choose between the two colors based on that 
	
	//COLOR = vec4(healthbarColor, healthbarMask); // setting alpha to healthbar mask will only ever equal 0 or 1, so background color isn't needed
	
	
	COLOR = vec4(healthbarTextureColor * healthbarMask * borderMask, 1.0);

	//COLOR = vec4(1.0,0.0,0.0, UV.x); // Test for alpha blending I guees

	
	//COLOR = vec4(vec3(borderMask), 1.0) ; // sdf output
}