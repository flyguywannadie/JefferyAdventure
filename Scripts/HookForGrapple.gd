extends Bullet
class_name HookForGrapple

var myGrapple: GrappleHook
var returnToDie: bool = false

var speedUp: float = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if(returnToDie):
		#queue_free() # replace this with code to pull the grapple back to the hook
		
		motion = lerp(Vector2(0,0), (myGrapple.bulletSpawn.global_position - global_position), delta * speedUp)
		
		speedUp *= 1.5
		
		if (myGrapple.bulletSpawn.global_position.distance_to(global_position) < 50 || lifetime <= 0 || position.distance_to(myGrapple.position) > 100000) :
			myGrapple.startCooldown()
			queue_free()
		
		translate(motion)
		
		rotation = atan2(-motion.y, -motion.x)
		return
	
	rotation = atan2(motion.y, motion.x)
	
	super._physics_process(delta)
	pass

func _hitCharacter(chara: Character):
	var move = (global_position - myGrapple.bulletSpawn.global_position).normalized() * 1000
	super._hitCharacter(chara)
	chara.setKnockback(-move.x, -move.y)

func _hitWall():
	var move = (global_position - myGrapple.bulletSpawn.global_position).normalized() * 1500
	myGrapple.KnockbackJeffery.emit( 1.5 * move.x, move.y)
	super._hitWall()

func ApplySlowdown(delta: float) -> void:
	motion = lerp(motion, Vector2(0,motion.y), slowdown * delta)
	motion += Vector2(0, 25) * delta
	pass

func _bulletDeath() -> void:
	returnToDie = true
	lifetime = 1
	pass
