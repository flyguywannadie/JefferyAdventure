extends Sword
class_name Dagger

var player: Jeffery

func _ready() -> void:
	super._ready()
	pass

func OnCreate() -> void:
	player = owner as Jeffery
	super.OnCreate()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	pass

func endCooldown() -> void:
	$AnimationPlayer.play("RESET")
	pass

func onUse() -> void:
	#print("weaponUse")
	startCooldown()
	#print("SwordSlash")
	
	#var test  = Vector2(1500, 0)
	#test = test.rotated(player.GunArm.rotation)
	#print(player.GunArm.rotation)
	#print(test)
	
	player.setKnockback(900 * scale.x, -600)
	#player.setKnockback(test.x, test.y/2)
	$AnimationPlayer.play("SwordSlash")
	pass
