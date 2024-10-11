extends Area2D

@export var myTrack: CamTrack
var camera: GameCamera

func _ready() -> void:
	for child in get_tree().root.get_child(0).get_children():
		if child is GameCamera:
			camera = child

func _on_body_entered(body: Node2D) -> void:
	var other: Jeffery = body as Jeffery
	if (other != null):
		camera.changeTrack(myTrack)
