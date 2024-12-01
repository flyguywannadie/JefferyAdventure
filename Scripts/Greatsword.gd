extends Sword
class_name Greatsword

var bonusDamage: int
var totalBonusTime: float

func _ready() -> void:
	visuals.material.set("shader_parameter/charge", 1.0)
	super._ready()
	pass

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	pass

func endCooldown() -> void:
	$AnimationPlayer.play("RESET")
	totalBonusTime = 0
	bonusDamage = 0
	pass

func onUse() -> void:
	#print("on click use")
	pressed = true
	$AnimationPlayer.play("SwordHold")
	pass

func onHold(delta: float) -> void:
	#print("on hold use")
	# will add damage based on held length
	
	if (totalBonusTime < 5):
		totalBonusTime += delta
		visuals.material.set("shader_parameter/charge", lerp(0.5, 0.1, totalBonusTime/5.0))
		bonusDamage = int(lerp(0, 8, totalBonusTime/5.0))
		if (totalBonusTime >= 5) :
			SoundManager.PlaySound("ChargeFinish")
			totalBonusTime = 5
	
	#scale = Vector2(1 + totalBonusTime, 1 + totalBonusTime)
	
	pass

func onRelease() -> void:
	#print("on release use")
	visuals.material.set("shader_parameter/charge", 1.0)
	pressed = false

	$AnimationPlayer.play("SwordSlash")
	#scale = Vector2(1, 1)
	cooldown = COOLDOWNLENGTH / lerpf(1, 4, (totalBonusTime/5.0))
	print("Cooldown Length ", cooldown)
	pass

func attackModifiers(t: Node) -> void:
	var s2 = t as Bullet
	if (s2):
		s2.damage += roundi(bonusDamage)
		print("slash Damage ", s2.damage, " added ", bonusDamage )

func swordDown() -> void:
	$AnimationPlayer.play("SwordDown")
	startCooldown()

func SwordSlashSound() -> void:
	playAudio("Slash")

func SwordSlam() -> void:
	GameManager.ShakeScreen(1.5, .5)

func ThrowPlayer():
	emit_signal("KnockbackJeffery", 1000 * lerpf(.25, 1.0, (totalBonusTime/5.0)) * global_scale.y, 0)
	GameManager.GetJeffery().hitStun = 1.0
	
