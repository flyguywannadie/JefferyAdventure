extends jeff_EventTrigger
class_name jeff_EnterEventTrigger

func _on_body_entered(body: Node2D) -> void:
	var jeff = body as Jeffery
	if (jeff != null) :
		Activate()
