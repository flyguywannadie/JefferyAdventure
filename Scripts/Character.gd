extends CharacterBody2D
class_name Character

@export var maxHealth: int = 10
var health: int 
var movement: Vector2
@export var GRAVITY: float = 9.8
@export var FRICTION: float = 9.8
var knockback: float

var flashFrames: int = 3
var framesLeft: int
@export var visuals: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = maxHealth
	pass

func _process(delta: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity = Vector2(movement.x + knockback, movement.y)
	
	if (framesLeft > 0) :
		framesLeft -= 1
		if (framesLeft <= 0) :
			visuals.material.set("shader_parameter/hit", false)
	
	# move knockback towards zero based on friction
	knockback = MoveTowardsZero(knockback, FRICTION)
	
	# redoing the same thing but with x movement
	movement.x = MoveTowardsZero(movement.x, FRICTION)
	
	if (sign(movement.x) != sign(knockback) && movement.x != 0) :
		knockback = MoveTowardsZero(knockback, FRICTION)
	
	move_and_slide()
	
	if (is_on_ceiling()):
		setMovement(movement.x, 0)
	
	if(!is_on_floor()):
		addMovement(0, GRAVITY)
	else:
		setMovement(movement.x, 0)
		
		# this is an attempt to make jeffery ramp of ramps when sliding, working kinda but not good
		#var v = Vector2(knockback, 0).rotated(get_floor_angle())
		#knockback = v.x
		#movement.y = -abs(v.y)
	
	if (is_on_wall()):
		knockback = 0

func MoveTowardsZero(value: float, speed: float) -> float:
	# moves a value towards 0 using a constant speed
	var sig = sign(value)
	var move = abs(value)
	move -= speed
	if(move <= 0) :
		return 0
	else :
		return move * sig

func addKnockback(x: float, y: float):
	knockback += x
	addMovement(0, y)
	pass

func setKnockback(x: float, y: float):
	knockback = x
	setMovement(movement.x, y)
	pass

func addMovementV(vec: Vector2):
	addMovement(vec.x, vec.y)
	pass

func addMovement(x: float, y: float):
	movement += Vector2(x, y)
	pass

func setMovementV(vec: Vector2):
	setMovement(vec.x, vec.y)
	pass

func setMovement(x: float, y: float):
	movement = Vector2(x, y)
	pass

func _die():
	print(name,	" has died")
	queue_free();
	pass

func takeDamage(damage: int):
	health -= damage
	print(name, " ouch ", health, " Took ", damage);
	if (visuals.material != null) :
		visuals.material.set("shader_parameter/hit", true)
		framesLeft = flashFrames
	if (health <= 0) :
		_die()
	pass
