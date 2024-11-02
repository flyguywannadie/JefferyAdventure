extends ColorRect

func _process(delta: float) -> void:
	if (Input.is_key_pressed(KEY_L)) :
		material.set("shader_parameter/colorSprites", !material.get("shader_parameter/colorSprites"))
	
	if (Input.is_key_pressed(KEY_U)) :
		material.set("shader_parameter/colorTint", Color(0.0,0.0,0.0))
	if (Input.is_key_pressed(KEY_I)) :
		material.set("shader_parameter/colorTint", Color(0.2,0.0,0.2))
	if (Input.is_key_pressed(KEY_O)) :
		material.set("shader_parameter/colorTint", Color(0.2,0.2,0.0))
	if (Input.is_key_pressed(KEY_P)) :
		material.set("shader_parameter/colorTint", Color(0.0,0.2,0.2))
