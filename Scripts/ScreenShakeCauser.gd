extends Node2D
class_name ScreenShakeCauser

enum ShakeTypes { DEFAULT, DIRECTION}
#@export var onReady

@export var shakeType: ShakeTypes
@export var intensity: float

func _ready() -> void:
	Shake()

func Shake() -> void:
	match (shakeType):
		ShakeTypes.DEFAULT:
			GameManager.ShakeScreen(intensity)
		ShakeTypes.DIRECTION:
			GameManager.ShakeScreenDirection(global_position,intensity)
