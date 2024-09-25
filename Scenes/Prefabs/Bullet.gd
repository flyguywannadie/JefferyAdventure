extends DamageArea

@export var velocity: float = 5
@export var grav: float = 9.8
@export var lifetime: float = 5
@export var pierce: int = 0

var prevPosition: Vector2
var motion: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	motion = Vector2(velocity, 0)
	motion = motion.rotated(rotation)
	pass # Replace with function body.

func _process(delta: float) -> void:
	
	lifetime -= delta
	if (lifetime <= 0) :
		_bulletDeath()
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	prevPosition = position
	
	var gravMotion = Vector2(0, grav * delta)
	motion += gravMotion
	translate(motion )
	
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(prevPosition, position)
	var result = space_state.intersect_ray(query)
	
	if (result):
		position = result.position
	
	pass

func _bulletDeath() -> void:
	queue_free()
	pass

func _bulletHit() -> void:
	print("bullet Hit Effect")
	pass

func _on_body_entered(body: Node2D) -> void:
	super._on_body_entered(body)
	pierce -= 1
	if (pierce < 0) :
		#motion = Vector2(0,0)
		#grav = 0
		_bulletDeath()
	else:
		_bulletHit()
	
	pass
