extends Area2D
class_name Doorway

var camera: GameCamera
var jeffery: Jeffery
var gamemanager: GameManager

func _ready() -> void:
	for child in $"..".get_children():
		if child is GameCamera:
			camera = child
		if child is Jeffery:
			jeffery = child
		if child is GameManager:
			gamemanager = child


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
