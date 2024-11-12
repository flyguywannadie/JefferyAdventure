extends Area2D
class_name Doorway

@export var doorID: int
@export var nextRoom: String
@export var closestCameraTrack: CamTrack
@export var closestCheckpoint: Node2D

func _on_body_entered(body: Node2D) -> void:
	print("Go To ", nextRoom)
	var isjeff = (body as Jeffery)
	if (isjeff == null) :
		return
	# should tell my room to start the process of leaving the room
	GameManager.call_deferred("SwapRoom",nextRoom, rotation, doorID)
