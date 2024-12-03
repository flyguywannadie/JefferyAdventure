extends Node2D

func EndGame():
	$"../EndingSequence".play("EndingScene")
	GameManager.StartCutscene()
	#GameManager.PauseGame()
	SoundManager.StopLoop(0)
	GameManager.Colortint.StopAnim()


func _on_back_to_title_pressed() -> void:
	#GameManager.ResumeGame()
	GameManager.ChangeScene("res://Scenes/StartMenu.tscn")
