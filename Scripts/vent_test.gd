extends StaticBody2D

@onready var coverCollision : CollisionShape2D = $CollisionShape2D

func Open() -> void:
	coverCollision.disabled = !coverCollision.disabled
	$Sprite2D.visible = !$Sprite2D.visible
