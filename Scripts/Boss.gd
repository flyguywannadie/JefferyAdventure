extends Enemy
class_name Boss

var gamemanager: GameManager

func _ready() -> void:
	# https://www.reddit.com/r/godot/comments/16kkpo2/finding_child_node_by_type/
	for child in $"..".get_children():
		if child is GameManager:
			gamemanager = child
	
	super._ready()
	pass

func _die() -> void:
	gamemanager.StartEvolution()
	super._die()
	pass
