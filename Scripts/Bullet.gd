extends DamageArea
class_name Bullet

@export var velocity: float = 5
@export var lifetime: float = 5
@export var slowdown: float = 1
@export var dieOnStop: bool
@export var knockback: Vector2 = Vector2(1,1)

var prevPosition: Vector2
var motion: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	motion = Vector2(velocity, 0)
	#print("before rot ", motion, " and ", rotation)
	motion = motion.rotated(rotation)
	#print("after rot ", motion)
	pass # Replace with function body.

func _process(delta: float) -> void:
	
	lifetime -= delta
	if (lifetime <= 0) :
		_bulletDeath()
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	prevPosition = position
	
	translate(motion)
	
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(prevPosition, position, 10)
	var result = space_state.intersect_ray(query)
	
	if (result):
		print("result hit")
		_on_body_entered(result.get("collider"))
	
	ApplySlowdown(delta)
	
	if (dieOnStop && motion.is_zero_approx()) :
		_bulletDeath()
	pass

func ApplySlowdown(delta: float) -> void:
	motion = lerp(motion, Vector2(0,0), slowdown * delta)
	pass

func _bulletDeath() -> void:
	queue_free()
	pass

func _hitCharacter(char: Character):
	char.setKnockback(knockback.x * sign(motion.x), knockback.y * sign(motion.y))
	super._hitCharacter(char)

func _hitWall():
	pass

func _on_body_entered(body: Node2D) -> void:
	var char = body as Character
	
	if (char):
		_hitCharacter(char)
	else:
		_hitWall()
	
	_bulletDeath()
	pass
