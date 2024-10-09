extends Sword
class_name Katana

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	pass

func endCooldown() -> void:
	pass

func onUse() -> void:
	#print("on click use")
	pressed = true
	#$AttackArm.visible = true
	pass

func onHold() -> void:
	#print("on hold use")
	$Sprite2D.position = Vector2(randf_range(0, 10), -128 + randf_range(-10, 10))
	pass

func onRelease() -> void:
	#print("on release use")
	pressed = false
	$Sprite2D.position = Vector2(0, -128)
	$AnimationPlayer.play("RESET")
	#$AttackArm.visible = false
	startCooldown()
	pass
