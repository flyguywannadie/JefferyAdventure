shader_type canvas_item;



//uniform float size;


// Gotten from here https://godotshaders.com/snippet/random-value/
float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

void vertex() {
	// Called for every vertex the material is visible on.
	//VERTEX = vec2(15,15);
	//VERTEX += vec2(10.0, 0.0);

	//VERTEX += vec2(cos(TIME), sin(TIME)) * 100.0;

	//float rate = 3.5;
	//VERTEX += vec2(sin(TIME), -(sqrt(sin(rate*mod(TIME, PI / rate))) + cos(TIME)))* 300.0;

	//VERTEX += vec2(random(UV * ceil(TIME)),random(UV * ceil(TIME))) * 100.0;
	//VERTEX += (vec2(random(UV * ceil(TIME)),random(UV * ceil(TIME))) * 25.0) - 12.5;


	//float c = cos(ceil(2.0*TIME));
	//float s = sin(ceil(2.0*TIME));
	//
	//VERTEX += vec2(((random(vec2(s, c))* 2.0) - 1.0),(random(vec2(c,s))* 2.0) - 1.0) * 100.0;
}

void fragment() {
	// Called for every pixel the material is visible on.
	//COLOR = texture(TEXTURE, UV);
	//
	//
	//const float EPSILON = 0.05;
	//const float SIZES = 0.1;
	//const float REP =  cos(mod(TIME, 3.0)) * 2.0;
	//if (COLOR.a > 0.0) {
		//if (UV.x + UV.y >= (SIZES + REP) - EPSILON && UV.x + UV.y <= (SIZES + 0.2+ REP) + EPSILON) {
			//COLOR = vec4(1.0);
		//}
	//}


	//COLOR = vec4(sqrt(UV * pow(tan(TIME),2.0)), pow(tan(TIME),-0.5), 1.0);

	//float thing = sqrt(sin(TIME));
	//COLOR = vec4(vec3(thing),1.0);

	//COLOR.rgb += vec3(smoothstep(0.2, 0.2 + 0.5, length(UV - vec2(0.5))));
	//if (COLOR.r > 0.5 && COLOR.g > 0.5 && COLOR.b > 0.5) {
		//COLOR.a = 0.0;
	//}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
