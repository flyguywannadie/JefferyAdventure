extends Node2D
class_name DeathEventTrigger

@export var active: bool = true

@export var WhoCanDie: Character

@export var whoICallTo: Node
@export var functionToCall: String

func _physics_process(delta: float) -> void:
	if (!active):
		return
	
	if (WhoCanDie == null) :
		Activate()


func Activate() -> void:
	active = false
	whoICallTo.call(functionToCall)
	pass
