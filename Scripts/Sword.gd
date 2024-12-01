extends Weapon
class_name Sword

#func spawnHitbox() -> void:
	#var s = slash.instantiate()
	##print("Position " , slashSpawn.position, ", scale ", slashSpawn.scale, ", rotation ", slashSpawn.rotation_degrees)
	##print("Position " , slashSpawn.global_position, ", scale ", slashSpawn.global_scale, ", rotation ", slashSpawn.global_rotation_degrees)
	##s.rotation_degrees = 0 if (global_scale.y == 1) else 90
	#spawnProjectile(s)
	#pass

#func getSlashSpawnPosition() -> Vector2:
	#return (projectileSpawn.global_position - GameManager.jeffery.global_position)

func spawnProjectile()-> void:
	var t = attack.instantiate()
	t.rotation = global_rotation
	t.position = (projectileSpawn.global_position - GameManager.jeffery.global_position)
	attackModifiers(t)
	GameManager.jeffery.add_child(t)
	t.owner = GameManager.projectileOwner


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
