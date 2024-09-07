extends Character
class_name Jeffery

var test: int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	#elocity = Vector2(0, -10)
	#Replace with function body.
	print(get_meta("testing"))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var sideVelocity: float
	
	if (Input.is_key_pressed(KEY_A)):
		sideVelocity += -200
	
	if (Input.is_key_pressed(KEY_D)):
		sideVelocity += 200
	
	velocity.x = sideVelocity;
	
	if (Input.is_action_just_pressed("cm_Jump")):
		velocity += Vector2(0,-500)
	
	super._process(delta)
	#position = Vector2(0,0)
	#move_and_slide()
	pass
