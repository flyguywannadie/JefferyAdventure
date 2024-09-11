extends Weapon
class_name Gun

var bullet = preload("res://Scenes/Prefabs/test_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	COOLDOWNSTART = 0.25
	damage = 5
	super._ready()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	pass

func onUse() -> void:
	print("testing")
	startCooldown()
	var t = bullet.instantiate()
	owner.add_child(t)
	t.position = get_global_mouse_position()
	pass
