extends Weapon
class_name Gun

@export var slash = preload("res://Scenes/Prefabs/test_slash.tscn")
@export var slashSpawn: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	#rotate(1 * delta)
	pass

func spawnHitbox() -> void:
	var s = slash.instantiate()
	owner.add_child(s)
	
	s.position = slashSpawn.position.rotated(rotation)
	pass

func endCooldown() -> void:
	$AnimationPlayer.play("SwordHold")
	pass

func onUse() -> void:
	#print("weaponUse")
	startCooldown()
	#print("SwordSlash")
	$AnimationPlayer.play("SwordSlash")
	pass
