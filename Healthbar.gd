extends ColorRect
class_name Healthbar

@export var whoITrack: Character

func _physics_process(delta: float) -> void:
	if (whoITrack == null) :
		return
	material.set("shader_parameter/fill", float(whoITrack.health)/float(whoITrack.maxHealth))
