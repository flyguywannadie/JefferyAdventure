extends Control

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("Pause") && get_tree().paused):
		resume()
	elif (event.is_action_pressed("Pause") && !get_tree().paused) :
		pause()

func _process(delta: float) -> void:
	if (visible) :
		$BlurEffect.material.set("shader_parameter/lod", lerp($BlurEffect.material.get("shader_parameter/lod"), 1.0, 3 * delta))

func pause():
	GameManager.PauseGame()
	
	visible = true
	$BlurEffect.material.set("shader_parameter/lod", 0.0)

func resume():
	GameManager.ResumeGame()
	visible = false

func _on_resume_pressed() -> void:
	resume()

func _on_back_to_title_pressed() -> void:
	resume()
	GameManager.ChangeScene("res://Scenes/StartMenu.tscn")
