extends Control

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("Pause") && get_tree().paused):
		resume()
	elif (event.is_action_pressed("Pause") && !get_tree().paused) :
		pause()

func pause():
	get_tree().paused = true
	visible = true

func resume():
	get_tree().paused = false
	visible = false

func _on_resume_pressed() -> void:
	resume()

func _on_back_to_title_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")
