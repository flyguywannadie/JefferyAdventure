extends Gun
class_name GrappleHook

@onready var tether: Line2D = $Tether
var player: Jeffery
var myHook: HookForGrapple

func OnCreate() -> void:
	player = owner as Jeffery
	super.OnCreate()

func _physics_process(delta: float) -> void:
	
	if (myHook != null) :
		tether.rotation = -player.GunArm.rotation
		var secondPoint = (myHook.global_position - projectileSpawn.global_position)
		tether.points = [Vector2(0,0), Vector2(secondPoint.x * global_scale.y, secondPoint.y)]
	
	super._physics_process(delta)
	pass

func onUse() -> void:
	#print("weaponUse")
	if (myHook == null) :
		spawnProjectile()
		SoundManager.PlaySound("GrappleHit")
		$AnimationPlayer.play("GunShoot")
	pass

func startCooldown() -> void:
	tether.points = []
	super.startCooldown()

func attackModifiers(t: Node) -> void:
	(t as HookForGrapple).myGrapple = $"."
	myHook = (t as HookForGrapple)

func endCooldown() -> void:
	$AnimationPlayer.play("RESET")
	pass
