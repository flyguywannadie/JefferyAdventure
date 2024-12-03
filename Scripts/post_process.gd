extends ColorRect
class_name ColorTint

@export var active: bool = true

func _ready() -> void:
	GameManager.Colortint = self

func _process(delta: float) -> void:
	
	if (!active) :
		return
	
	if (Input.is_key_pressed(KEY_H)) :
		material.set("shader_parameter/colorSprites", !material.get("shader_parameter/colorSprites"))
	
	var currentColor = material.get("shader_parameter/colorTint")
	var colorAdd : Color = Color(0.0,0.0,0.0,0.0)
	
	if (Input.is_key_pressed(KEY_I)) :
		colorAdd = Color(1.0/255.0,0.0,0.0,0.0)
	if (Input.is_key_pressed(KEY_O)) :
		colorAdd = Color(0.0,1.0/255.0,0.0,0.0)
	if (Input.is_key_pressed(KEY_P)) :
		colorAdd = Color(0.0,0.0,1.0/255.0,0.0)
	
	if (material.get("shader_parameter/colorTint").r < 1.0) :
		currentColor = currentColor + colorAdd
		currentColor.clamp(Color(0.0,0.0,0.0,1.0), Color(1.0,1.0,1.0,1.0))
		material.set("shader_parameter/colorTint", currentColor)
		
	
	if (Input.is_key_pressed(KEY_U)) :
		material.set("shader_parameter/colorTint", Color(0.0,0.0,0.0,0.0))
	
	if (Input.is_key_pressed(KEY_K)) :
		material.set("shader_parameter/colorTint", lerp(currentColor, Color(1.0,1.0,1.0), delta))
	
	if (Input.is_key_pressed(KEY_L)) :
		material.set("shader_parameter/colorTint", lerp(currentColor, Color(0.0,0.0,0.0), delta))
	
	if (Input.is_key_pressed(KEY_J)) :
		print(currentColor)
		print("%x" % currentColor.to_rgba32())
		

func StartAnim():
	$"../AlarmAnim".play("Alarm")

func StopAnim() :
	$"../AlarmAnim".stop(true)
