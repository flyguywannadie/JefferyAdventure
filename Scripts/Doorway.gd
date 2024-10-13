extends Area2D
class_name Doorway


@export var doorID: int
@export var nextRoom: String
@export var myRoom: Room

func _ready() -> void:
	myRoom = owner as Room

func _on_body_entered(body: Node2D) -> void:
	print("Go To ", nextRoom)
	
	# should tell my room to start the process of leaving the room
	myRoom.call_deferred("leaveRoom", nextRoom, rotation)
	pass
