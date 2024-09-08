extends CharacterBody2D
class_name Character

var health: int = 100
var movement: Vector2
var GRAVITY: float = 9.8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	velocity = movement;
	
	move_and_slide()
	
	if(!is_on_floor()):
		_addMovement(0, GRAVITY)
	else:
		_setMovement(movement.x, 0)
	pass

func _addMovement(x: float, y: float):
	movement += Vector2(x, y)
	pass

func _setMovement(x: float, y: float):
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
