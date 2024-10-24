extends Control

@onready var the_menu: VBoxContainer = $TheMenu
@onready var options: Control = $Options

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	the_menu.visible = true
	options.visible = false
	pass # Replace with function body.

func _on_start_pressed() -> void:
	GameManager.MakeFirstScene()
	GameManager.ChangeScene("res://Scenes/node_2d.tscn")
	pass

func _on_quit_pressed() -> void:
	get_tree().quit(0)
	pass # Replace with function body.


func _on_options_pressed() -> void:
	the_menu.visible = false
	options.visible = true
	pass # Replace with function body.


func _on_back_options_pressed() -> void:
	the_menu.visible = true
	options.visible = false
	pass # Replace with function body.
