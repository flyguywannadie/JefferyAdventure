extends CharacterBody2D
class_name Character



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity += Vector2(0,9.8);
	
	move_and_slide()
	
	if (is_on_floor()):
		velocity.x -= velocity.x * 0.95 * delta;
	
	pass
