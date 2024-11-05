extends Weapon
class_name Sword

@export var slash : PackedScene = preload("res://Scenes/Prefabs/Projectiles/test_slash.tscn")
@export var slashSpawn: Node2D

func spawnHitbox() -> void:
	var s = slash.instantiate()
	#print("Position " , slashSpawn.position, ", scale ", slashSpawn.scale, ", rotation ", slashSpawn.rotation_degrees)
	#print("Position " , slashSpawn.global_position, ", scale ", slashSpawn.global_scale, ", rotation ", slashSpawn.global_rotation_degrees)
	#s.rotation_degrees = 0 if (global_scale.y == 1) else 90
	owner.add_child(s)
	s.position = getSlashSpawnPosition()
	pass

func getSlashSpawnPosition() -> Vector2:	
	return (slashSpawn.global_position - GameManager.jeffery.global_position)

func endCooldown() -> void:
	$AnimationPlayer.play("RESET")
	pass

func onUse() -> void:
	#print("weaponUse")
	startCooldown()
	playAudio("Slash")
	#print("SwordSlash")
	$AnimationPlayer.play("SwordSlash")
	pass
