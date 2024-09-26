extends CharacterBody2D
class_name Character

@export var health: int = 10
var movement: Vector2
@export var GRAVITY: float = 9.8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	velocity = movement;
	
	move_and_slide()
	
	if(!is_on_floor()):
		addMovement(0, GRAVITY)
	else:
		setMovement(movement.x, 0)
	
	if (is_on_ceiling()):
		setMovement(movement.x, 0)
		position.y += 4
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func addMovement(x: float, y: float):
	movement += Vector2(x, y)
	pass

func setMovement(x: float, y: float):
	movement = Vector2(x, y)
	pass

func _die():
	print("I have died")
	queue_free();
	pass

func takeDamage(damage: int):
	health -= damage
	print("ouch ", health);
	if (health <= 0) :
		_die()
	pass
