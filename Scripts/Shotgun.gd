extends Gun
class_name Shotgun

func SpawnBullet() -> void:
	var range = 4
	for n in range(range) :
		var t = bullet.instantiate()
		(t as Bullet).velocity += randi_range(-20,20)
		t.rotation = global_rotation + deg_to_rad(randi_range(-22,22))
		t.position = bulletSpawn.global_position
		owner.owner.add_child(t)
		pass
