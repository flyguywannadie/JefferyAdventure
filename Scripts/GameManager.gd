extends Node2D
class_name GameManager

const TESTGUYBOUNCE = preload("res://Scenes/Prefabs/testguybounce.tscn")
@onready var evolution_screen: EvolutionScreen = $"../CanvasLayer/EvolutionScreen"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if (Input.is_key_pressed(KEY_G)):
		print("spawn thing")
		var c = TESTGUYBOUNCE.instantiate()
		add_child(c)
		c.position = Vector2(randf_range(-1000,1000),-500)
	
	if (Input.is_key_pressed(KEY_V)):
		StartEvolution("d")
	if (Input.is_key_pressed(KEY_B)):
		StartEvolution("c")
	if (Input.is_key_pressed(KEY_N)):
		StartEvolution("f")
	
	pass

func StartEvolution(piece: String) -> void:
	get_tree().paused = true
	evolution_screen.StartEvolution(piece)
	pass
