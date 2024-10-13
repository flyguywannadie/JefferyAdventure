extends Control
class_name EvolutionScreen

@onready var jeffery: Jeffery = $"../../Jeffery"
var evoPiece: String
@onready var game_manager: GameManager = $"../../GameManager"

func _ready() -> void:
	visible = false
	evoPiece = ""

func StartEvolution(piece: String) -> void:
	visible = true
	evoPiece = piece

func CloseEvolution() -> void:
	visible = false
	get_tree().paused = false
	evoPiece = ""


func _on_Sword_button_pressed() -> void:
	jeffery.EvolveWeapon(false, evoPiece)
	game_manager.gameState += "s "
	CloseEvolution()
	pass # Replace with function body.


func _on_Gun_button_pressed() -> void:
	jeffery.EvolveWeapon(true, evoPiece)
	game_manager.gameState += "g "
	CloseEvolution()
	pass # Replace with function body.
