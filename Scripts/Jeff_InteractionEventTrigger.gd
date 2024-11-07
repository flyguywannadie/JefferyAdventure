extends Area2D
class_name jeff_InteractionEventTrigger

@export var whoICallTo: Node
@export var functionToCall: String

@export var oneTime: bool = false

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
		print("InteractEvent")
		if (event.is_action_pressed("jef_interact")) :
			if (whoICallTo != null) :
				whoICallTo.call(functionToCall)
				if (oneTime) :
					queue_free()
			else :
				print_debug("There is no one to call to")
			
