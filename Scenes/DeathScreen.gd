extends Control
class_name DeathScreen

@onready var RestartMenu: MarginContainer = $MarginContainer

func _ready() -> void:
	visible = false
	GameManager.deathScreen = self

func BeginGameOver() -> void:
	visible = true
	$AnimationPlayer.play("FadeIn")

func _physics_process(delta: float) -> void:
	pass

func nowPauseGame() -> void:
	GameManager.PauseGame()

func buttonPressed() -> void:
	visible = false

func _on_retry_pressed() -> void:
	$AnimationPlayer.play("Fadeout")
	GameManager.JefferyRetry()

func _on_quit_pressed() -> void:
	buttonPressed()
	GameManager.ResumeGame()
	GameManager.ChangeScene("res://Scenes/StartMenu.tscn")
