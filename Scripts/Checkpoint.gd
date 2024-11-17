extends Area2D

@onready var check_point: Node2D = $".."

func _on_body_entered(body: Node2D) -> void:
	GameManager.SetCheckpoint(check_point)
