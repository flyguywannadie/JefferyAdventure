extends Weapon
class_name Gun

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	#rotate(1 * delta)
	pass

func onUse() -> void:
	#print("weaponUse")
	startCooldown()
	spawnProjectile()
	playAudio("Shoot")
	$AnimationPlayer.play("GunShoot")
	pass

func endCooldown() -> void:
	$AnimationPlayer.play("RESET")
	pass
