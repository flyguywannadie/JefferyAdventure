extends Area2D

@export var myTrack: CamTrack

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	var other: Jeffery = body as Jeffery
	if (other != null):
		GameManager.GetGameCamera().changeTrack(myTrack)
