extends Gun
class_name Shotgun

func spawnProjectile() -> void:
	var bulletAmount = 4
	for n in range(bulletAmount) :
		super.spawnProjectile()
		pass

func attackModifiers(t: Node) -> void:
	(t as Bullet).velocity += randi_range(-20,20)
	(t as Bullet).rotation += deg_to_rad(randi_range(-22,22))
