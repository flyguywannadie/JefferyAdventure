extends Enemy
class_name Boss

var gamemanager: GameManager
@export var pieceIHold : String

func _ready() -> void:
	# https://www.reddit.com/r/godot/comments/16kkpo2/finding_child_node_by_type/
	for child in $"..".get_children():
		if child is GameManager:
			gamemanager = child
	
	match(randi_range(0, 2)):
		0:
			pieceIHold = "d"
		1:
			pieceIHold = "c"
		2:
			pieceIHold = "f"
	
	super._ready()
	pass

func _die() -> void:
	gamemanager.StartEvolution(pieceIHold)
	super._die()
	pass
