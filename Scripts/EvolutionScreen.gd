extends Control
class_name EvolutionScreen

var evoPiece: String

func _ready() -> void:
	visible = false
	GameManager.evolutionScreen = self

func StartEvolution(piece: String) -> void:
	visible = true
	evoPiece = piece
	var txt = "Charge Piece"
	if (evoPiece == "d") :
		txt = "Deadly Piece"
	elif (evoPiece == "f") :
		txt = "Fast Piece"
	$Label2.text = txt
	
	var ang = 0
	if (evoPiece == "d") :
		ang = 130
	elif (evoPiece == "f") :
		ang = 270
	$ColorRect.material.set("shader_parameter/angle", ang)

#func _process(delta: float) -> void:
	#if ($MarginContainer/HBoxContainer/TextureButton2.is_hovered() || $MarginContainer/HBoxContainer/TextureButton.is_hovered()):
		#$MarginContainer/HBoxContainer.set("theme_override_constants/separation", 64)
	#else :
		#$MarginContainer/HBoxContainer.set("theme_override_constants/separation", 192)

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
