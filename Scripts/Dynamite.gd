extends Bullet
class_name Dynamite

var thrownAt: float

func _ready() -> void:
	thrownAt = position.y + 10
	super._ready()
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	
	motion.y += 20 * delta
	
	if (position.y > thrownAt) :
		_bulletDeath()
		return
	
	super._physics_process(delta)
	pass
