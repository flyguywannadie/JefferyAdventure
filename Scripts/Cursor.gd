extends Sprite2D
class_name GameCursor

@export var menu : Texture
@export var game : Texture

func _ready() -> void:
	GameManager.Cursor = self
	process_mode = PROCESS_MODE_ALWAYS

func _process(delta: float) -> void:
	#if (GameManager.camera != null) :
		#global_position = GameManager.camera.get_global_mouse_position()
	#else:
	global_position = get_viewport().get_mouse_position()

func MenuCursor() :
	texture = menu
	material.set("shader_parameter/active", false)

func GameCursor() :
	texture = game
	material.set("shader_parameter/active", true)
