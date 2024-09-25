extends Character


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if (is_on_floor()):
		setMovement(0,-500)
	
	super._physics_process(delta)
	pass
