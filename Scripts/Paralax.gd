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
	
	global_position.x = startPos.x - ((cam.global_position.x - startPos.x)*(1.0 + distance))
	global_position.y = startPos.y
	
	
	var scal = 1.0 / (1.0 + distance)
	global_scale = Vector2(scal,scal)
