extends Control

func _ready() -> void:
	visible = false

func CloseEvolution() -> void:
	visible = false
	get_tree().paused = false


func _on_Sword_button_pressed() -> void:
	CloseEvolution()
	pass # Replace with function body.


func _on_Gun_button_pressed() -> void:
	CloseEvolution()
	pass # Replace with function body.
