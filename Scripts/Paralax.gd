extends Sprite2D

var cam : Node2D
var startPos : Vector2
@export var distance: float

func _ready() -> void:
	cam = GameManager.camera
	call_deferred("_afterReady")

func _afterReady() -> void:
	startPos = global_position
	print(startPos)

func _process(delta: float) -> void:
	#print(cam.global_position, " and ", startPos)
	
	global_position.x = cam.global_position.x
	global_position.y = cam.global_position.y
