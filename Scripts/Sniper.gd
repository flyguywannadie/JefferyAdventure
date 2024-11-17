extends Gun
class_name Sniper

var charge: float = 0

func onUse() -> void:
	visuals.material.set("shader_parameter/charge", 1.0)
	pressed = true
	pass

func onHold(delta: float) -> void:
	# will add damage based on held length
	if (charge < 1) :
		charge += delta / 2
		if (charge >= 1) :
			SoundManager.PlaySound("ChargeFinish")
			charge = 1
	
	visuals.material.set("shader_parameter/charge", lerp(0.85, 0.1, charge))
	pass

func onRelease() -> void:
	#print("weaponUse")
	cooldown -= charge * 0.75
	visuals.material.set("shader_parameter/charge", 1.0)
	startCooldown()
	spawnProjectile()
	$AnimationPlayer.play("GunShoot")
	charge = 0
	pressed = false
	pass

func attackModifiers(t: Node) -> void:
	var b = (t as Bullet)
	b.knockback = lerp(b.knockback, b.knockback * 3, charge)
	b.velocity += 60 * charge
	b.damage += int(3 * charge)
	pass

func endCooldown() -> void:
	$AnimationPlayer.play("RESET")
	pass
