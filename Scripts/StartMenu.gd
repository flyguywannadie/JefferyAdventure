extends Control

@onready var the_menu: Control = $MainMenu
@onready var options: Control = $Options
@onready var menuAnims: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.UseMenuCursor()
	SoundManager.StopLoop(0)
	#the_menu.visible = true
	#options.visible = false
	pass # Replace with function body.

func _on_start_pressed() -> void:
	GameManager.ChangeScene("res://Scenes/node_2d.tscn")
	GameManager.MakeFirstScene()
	pass

func _on_quit_pressed() -> void:
	get_tree().quit(0)
	pass # Replace with function body.


func _on_options_pressed() -> void:
	menuAnims.play("GoToOptions")
	pass # Replace with function body.


func _on_back_options_pressed() -> void:
	menuAnims.play("GoToMain")
	pass # Replace with function body.
