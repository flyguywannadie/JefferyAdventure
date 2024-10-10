extends CharacterBody2D
class_name Character

@export var health: int = 10
var movement: Vector2
@export var GRAVITY: float = 9.8
@export var FRICTION: float = 9.8
var knockback: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity = Vector2(movement.x + knockback, movement.y)
	
	# basically making knockback decrease regarless of sign
	var sig = sign(knockback)
	var knock = abs(knockback)
	knock -= FRICTION
	if (knock <= 0) :
		knockback = 0
	else :
		knockback = knock * sig
	
	#redoing the same thing but with x movement
	sig = sign(movement.x)
	var moveX = abs(movement.x)
	moveX -= FRICTION
	if(moveX <= 0) :
		movement.x = 0
	else :
		movement.x = moveX * sig
	
	move_and_slide()
	
	if(!is_on_floor()):
		addMovement(0, GRAVITY)
	else:
		setMovement(movement.x, 0)
	
	if (is_on_wall()):
		knockback = 0
	
	if (is_on_ceiling()):
			setMovement(movement.x, 0)
			position.y += 4
	
	pass

func setKnockback(x: float, y: float):
	knockback = x
	setMovement(0, y)
	pass

func addMovement(x: float, y: float):
	movement += Vector2(x, y)
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
	if (health <= 0) :
		_die()
	pass
