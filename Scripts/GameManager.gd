extends Node2D

const TESTGUYBOUNCE = preload("res://Scenes/Prefabs/testguybounce.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if (Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit(0)
	
	
	if (Input.is_key_pressed(KEY_G)):
		print("spawn thing")
		var c = TESTGUYBOUNCE.instantiate()
		add_child(c)
		c.position = Vector2(randf_range(-1000,1000),-500)
	
	pass
