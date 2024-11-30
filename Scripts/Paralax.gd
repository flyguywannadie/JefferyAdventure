extends Sprite2D

var cam : Node2D
var startPos : Vector2
@export var distance: float

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	cam = GameManager.camera
	call_deferred("_afterReady")

func _afterReady() -> void:
	startPos = global_position
	#offset = position
	#position = Vector2.ZERO
	z_index = -distance
	if (z_index >= 0) :
		z_index += 15
	#print(startPos)

func _process(delta: float) -> void:
	
	#z_index = -distance
	
	# I HAVE NO IDEA WHY THIS IS SO DIFFICULT TO FIGURE OUT THE MATH FOR. I AM JUST MISSING SOMETHING I GUESS.d
	
	#print(cam.global_position, " and ", startPos)
	
	#if (distance == 0) :
		#return
	
	#var towardsCamera = cam.global_position - startPos
	
	#global_position = lerp(towardsCamera, startPos, 1/distance)
	
	#global_position.x = cam.global_position.x + (startPos.x - cam.global_position.x)/distance
	#global_position.y = startPos.y
	
	var a = Vector3(startPos.x,startPos.y,distance)
	var c = Vector3( cam.global_position.x, cam.global_position.y, GameManager.camDistance)
	
	var d = a-c
	
	var b : Vector2
	b.x = ((a.z/d.z)*d.x) + a.x
	b.y = ((a.z/d.z)*d.y) + a.y
	
	global_position = b + ((startPos - b) * (distance/GameManager.camDistance))
	#
	#print(b)
	
	scale.x = 1.0 - (distance / GameManager.camDistance)
	scale.y = 1.0 - (distance / GameManager.camDistance)
