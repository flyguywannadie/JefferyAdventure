extends Control
class_name EvolutionScreen

var evoPiece: String

func _ready() -> void:
	visible = false
	GameManager.evolutionScreen = self

func StartEvolution(piece: String) -> void:
	visible = true
	evoPiece = piece

func CloseEvolution() -> void:
	visible = false
	GameManager.ResumeGame()

func doEvolution(weaponUsed: String) -> void:
	GameManager.GetJeffery().EvolveWeapon(weaponUsed == "g ", evoPiece)
	GameManager.AddToGameState(weaponUsed)
	CloseEvolution()

func _on_Sword_button_pressed() -> void:
	doEvolution("s ")


func _on_Gun_button_pressed() -> void:
	doEvolution("g ")
