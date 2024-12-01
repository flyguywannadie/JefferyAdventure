extends DamageArea
class_name Bullet

@export var velocity: float = 5
@export var lifetime: float = 5
@export var slowdown: float = 1
@export var dieOnStop: bool
@export var persistantEffect: bool
@export var knockback: Vector2 = Vector2(1,1)

@export var HitEffect: PackedScene
@export var deathEffect: PackedScene

var prevPosition: Vector2
var motion: Vector2

@export var bulletHitSound : String
@export var bulletDeathSound : String

var alreadyHit: Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	motion = Vector2(velocity, 0)
	#print("before rot ", motion, " and ", rotation)
	motion = motion.rotated(rotation)
	#print("after rot ", motion)

func _process(delta: float) -> void:
	
	lifetime -= delta
	if (lifetime <= 0) :
		_bulletDeath()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	prevPosition = position
	
	translate(motion)
	
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(prevPosition, position, collision_mask)
	var result = space_state.intersect_ray(query)
	
	if (result):
		print("result hit")
		_on_body_entered(result.get("collider"))
	
	ApplySlowdown(delta)
	
	if (dieOnStop && motion.distance_to(Vector2(0,0)) < 1) :
		_bulletDeath()

func ApplySlowdown(delta: float) -> void:
	motion = lerp(motion, Vector2(0,0), slowdown * delta)

func PlayAudio(name: String, Volume: float = 0.0) -> void:
	SoundManager.PlaySound(name, Volume)

func _bulletDeath() -> void:
	if (deathEffect != null):
		var de = deathEffect.instantiate()
		de.position = global_position
		owner.call_deferred("add_child", de)
		de.set_deferred("owner", owner)
	PlayAudio(bulletDeathSound)
	queue_free()

func _hitCharacter(chara: Character):
	chara.setKnockback(knockback.x * sign(motion.x), knockback.y * sign(motion.y))
	spawnHitEffect()
	PlayAudio(bulletHitSound)
	
	super._hitCharacter(chara)

func _hitWall():
	spawnHitEffect()
	PlayAudio(bulletHitSound)

func spawnHitEffect() -> void:
	if (HitEffect != null):
		var he = HitEffect.instantiate()
		he.position = global_position
		owner.call_deferred("add_child", he)
		he.set_deferred("owner", owner)

func _on_body_entered(body: Node2D) -> void:
	var char = body as Character
	
	if (alreadyHit.has(body)):
		return
	alreadyHit.append(body)
	
	if (char):
		_hitCharacter(char)
	else:
		_hitWall()
	
	if (persistantEffect) :
		collision_mask = 0
		collision_layer = 0
	else:
		_bulletDeath()
