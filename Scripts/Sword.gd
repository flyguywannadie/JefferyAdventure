extends Weapon
class_name Sword

@export var slash : PackedScene = preload("res://Scenes/Prefabs/Projectiles/test_slash.tscn")
@export var slashSpawn: Node2D

func spawnHitbox() -> void:
	var s = slash.instantiate()
	owner.add_child(s)
	
	s.position = slashSpawn.position.rotated(rotation) * scale
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
