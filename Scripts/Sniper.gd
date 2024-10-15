extends Gun
class_name Sniper

var charge: float = 0

func onUse() -> void:
	pressed = true
	pass

func onHold(delta: float) -> void:
	# will add damage based on held length
	if (charge < 1) :
		charge += delta / 2
		print(charge)
	else :
		charge = 1
	
	pass

func onRelease() -> void:
	#print("weaponUse")
	cooldown -= charge * 0.75
	startCooldown()
	SpawnBullet()
	$AnimationPlayer.play("GunShoot")
	charge = 0
	pressed = false
	pass

func SpawnBullet() -> void:
	var t = bullet.instantiate()
	var b = (t as Bullet)
	b.knockback = lerp(b.knockback, b.knockback * 3, charge)
	b.velocity += 60 * charge
	b.damage += int(3 * charge)
	t.rotation = global_rotation
	t.position = bulletSpawn.global_position
	owner.owner.add_child(t)
	pass

func endCooldown() -> void:
	$AnimationPlayer.play("RESET")
	pass
