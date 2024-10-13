extends Sword
class_name Chainsaw

@export var idleFrames : Array[Texture]

func _physics_process(delta: float) -> void:
	if (!pressed && readyUse) :
		$Sprite2D.texture = idleFrames[randi_range(0,3)]
	elif (pressed && !Input.is_action_pressed(inputAction)):
		pressed = false
		$Sprite2D.position = Vector2(0, -128)
		$AnimationPlayer.play("RESET")
		#$AttackArm.visible = false
	super._physics_process(delta)
	pass

func endCooldown() -> void:
	pass

func onUse() -> void:
	#print("on click use")
	pressed = true
	$AnimationPlayer.play("Swing")
	#$AttackArm.visible = true
	pass

func swingDonw() -> void:
	$AnimationPlayer.play("attack")
	pass

func onHold(delta: float) -> void:
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
