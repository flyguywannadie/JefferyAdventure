extends StaticBody2D

@onready var coverCollision : CollisionShape2D = $CollisionShape2D

func Open() -> void:
	coverCollision.disabled = !coverCollision.disabled
	#$VentCover/Sprite2D.visible = !$VentCover/Sprite2D.visible
	if (coverCollision.disabled) :
		$AnimationPlayer.play("Open")
	else :
		$AnimationPlayer.play("Close")
