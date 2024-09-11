extends Character
class_name Jeffery

var test: int = 10
var speed: float = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	#elocity = Vector2(0, -10)
	#Replace with function body.
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var sideVelocity: float = 0
	
	if (Input.is_key_pressed(KEY_A)):
		sideVelocity += -speed
	
	if (Input.is_key_pressed(KEY_D)):
		sideVelocity += speed
	
	_setMovement(sideVelocity, movement.y)
	
	if (Input.is_action_just_pressed("jef_Jump")):
		_addMovement(0,-500)
	
	super._process(delta)
	#position = Vector2(0,0)
	#move_and_slide()
	pass
