extends jeff_EventTrigger
class_name jeff_InteractionEventTrigger

@onready var interactButton: Sprite2D = $E

func _ready() -> void:
	interactButton.visible = false

func _on_body_entered(body: Node2D) -> void:
	if (body as Jeffery == null) :
		return
	interactButton.visible = true;

func _on_body_exited(body: Node2D) -> void:
	if (body as Jeffery == null) :
		return
	interactButton.visible = false


func _input(event: InputEvent) -> void:
	if (interactButton.visible) :
		if (event.is_action_pressed("jef_interact")) :
			Activate()
