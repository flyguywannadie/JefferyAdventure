extends Area2D
class_name DamageArea

@export var damage: int = 10

func _hitCharacter(char: Character):
	char.takeDamage(damage)

func _on_body_entered(body: Node2D) -> void:
	var test: Character = body as Character
	if (test != null) :
		_hitCharacter(test)
