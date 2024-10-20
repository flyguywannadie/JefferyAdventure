extends Sword
class_name Katana

var bonusDamage: int
var totalBonusTime: float

func _ready() -> void:
	super._ready()
	pass

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	pass

func endCooldown() -> void:
	$AnimationPlayer.play("RESET")
	totalBonusTime = 0
	pass

func onUse() -> void:
	#print("on click use")
	pressed = true
	$AnimationPlayer.play("SwordHold")
	pass

func onHold(delta: float) -> void:
	#print("on hold use")
	# will add damage based on held length
	
	if (totalBonusTime < 3):
		totalBonusTime += delta
	
	#scale = Vector2(1 + totalBonusTime, 1 + totalBonusTime)
	
	pass

func onRelease() -> void:
	#print("on release use")
	pressed = false
	startCooldown()
	$AnimationPlayer.play("SwordSlash")
	#scale = Vector2(1, 1)
	cooldown = COOLDOWNLENGTH / clampf(totalBonusTime, 1, 3)
	print("Cooldown Length ", cooldown)
	pass

func spawnHitbox() -> void:
	var s = slash.instantiate()
	s.position = getSlashSpawnPosition()
	#s.rotation_degrees = 0 if (global_scale.y == 1) else 90
	var s2 = s as Bullet
	if (s2):
		s2.damage += roundi(totalBonusTime)
		print("slash Damage ", s2.damage, " added ", totalBonusTime )
	owner.add_child(s)
	pass

func swordDown() -> void:
	$AnimationPlayer.play("SwordDown")
