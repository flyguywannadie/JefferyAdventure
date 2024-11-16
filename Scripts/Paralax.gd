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
	print(startPos)

func _process(delta: float) -> void:
	# I HAVE NO IDEA WHY THIS IS SO DIFFICULT TO FIGURE OUT THE MATH FOR. I AM JUST MISSING SOMETHING I GUESS.
	
	#print(cam.global_position, " and ", startPos)
	
	#if (distance == 0) :
		#return
	
	#var towardsCamera = cam.global_position - startPos
	
	#global_position = lerp(towardsCamera, startPos, 1/distance)
	
	#global_position.x = cam.global_position.x + (startPos.x - cam.global_position.x)/distance
	#global_position.y = startPos.y
	
	var a = Vector3(startPos.x,startPos.y,distance)
	var c = Vector3( cam.global_position.x, cam.global_position.y, 100.0)
	var e =  a
	
	var d = a-c
	
	var b : Vector2
	b.x = ((e.z/d.z)*d.x) + e.x
	b.y = ((e.z/d.z)*d.y) + e.y
	
	global_position.x = b.x
	#
	#print(b)
	pass
