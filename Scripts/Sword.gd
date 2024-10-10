extends Weapon
class_name Sword

@export var slash : PackedScene = preload("res://Scenes/Prefabs/Projectiles/test_slash.tscn")
@export var slashSpawn: Node2D

func spawnHitbox() -> void:
	var s = slash.instantiate()
	s.position = slashSpawn.position.rotated(rotation) * scale
	s.rotation_degrees = 0 if (scale.x == 1) else 90
	owner.add_child(s)
	pass

func endCooldown() -> void:
	$AnimationPlayer.play("RESET")
	pass

func onUse() -> void:
	#print("weaponUse")
	startCooldown()
	#print("SwordSlash")
	$AnimationPlayer.play("SwordSlash")
	pass
