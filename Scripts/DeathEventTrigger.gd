extends Node2D
class_name DeathEventTrigger

@export var WhoWillDie: Character

@export var whoICallTo: Node
@export var functionToCall: String

func _physics_process(delta: float) -> void:
	if (WhoWillDie == null) :
		Activate()


func Activate() -> void:
	if (whoICallTo != null) :
		whoICallTo.call(functionToCall)
		print("Death Event Has Occured")
		queue_free()
	else :
		print_debug("There is no one to call to")
