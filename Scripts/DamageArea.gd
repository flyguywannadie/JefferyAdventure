extends Area2D
class_name DamageArea

@export var damage: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	var test: Character = body as Character
	if (test != null) :
		test.takeDamage(damage)
