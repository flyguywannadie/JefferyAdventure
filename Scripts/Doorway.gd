extends Area2D
class_name Doorway

@export var nextRoom: PackedScene

@export var myRoom: Room

func _ready() -> void:
	myRoom = owner as Room

func _on_body_entered(body: Node2D) -> void:
	print("Touched Jeffery")
	pass
