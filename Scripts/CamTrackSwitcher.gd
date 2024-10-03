extends Area2D

@export var myTrack: CamTrack
@onready var camera: GameCamera = $"../../Camera2D"

func _on_body_entered(body: Node2D) -> void:
	var other: Jeffery = body as Jeffery
	if (other != null):
		camera.changeTrack(myTrack)
