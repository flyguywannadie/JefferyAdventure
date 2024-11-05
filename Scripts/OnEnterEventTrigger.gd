extends Area2D
class_name EnterEventTrigger

@export var whoICallTo: Node
@export var functionToCall: String

func _on_body_entered(body: Node2D) -> void:
	var jeff = body as Jeffery
	if (jeff != null) :
		if (whoICallTo != null) :
			whoICallTo.call(functionToCall)
			print("Enter Event Has Occured")
			queue_free()
		else :
			print_debug("There is no one to call to")
