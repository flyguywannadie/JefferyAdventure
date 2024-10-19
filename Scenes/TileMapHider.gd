extends TileMapLayer

@export var startHiden: bool = true

func _ready() -> void:
	if (startHiden) :
		Hide()
	else:
		Show()

func Hide():
	visible = false
	collision_enabled = false
	pass

func Show():
	visible = true
	collision_enabled = true
	pass
