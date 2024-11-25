extends Bullet
class_name Dynamite

var thrownAt: float

func _ready() -> void:
	thrownAt = position.y + 10
	
	rotation_degrees += randf_range(-15,15)
	
	velocity += randf_range(-5,5)
	
	super._ready()

func _physics_process(delta: float) -> void:
	
	motion.y += 20 * delta
	
	if (motion.y > 0) :
		z_index = 100
	
	#if (position.y > thrownAt) :
		#_bulletDeath()
		#return
	
	super._physics_process(delta)
