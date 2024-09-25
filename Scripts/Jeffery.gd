extends Character
class_name Jeffery

var test: int = 10
@export var speed: float = 200

const TEST_WEAPON = preload("res://Scenes/Prefabs/TestWeapon.tscn")
@onready var gun_holder: Node2D = $GunArm/GunHolder
var currentGun: Weapon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	var gun = TEST_WEAPON.instantiate()
	gun_holder.add_child(gun)
	gun.owner = $"."
	currentGun = gun as Weapon
	#elocity = Vector2(0, -10)
	#Replace with function body.
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	var sideVelocity: float = 0
	
	if (Input.is_key_pressed(KEY_A)):
		sideVelocity += -speed
	
	if (Input.is_key_pressed(KEY_D)):
		sideVelocity += speed
	
	setMovement(sideVelocity, movement.y)
	
	if (Input.is_action_just_pressed("jef_Jump")):
		setMovement(0,-1400)
	
	var mousePos = get_viewport().get_camera_2d().get_global_mouse_position()
	$GunArm.look_at(mousePos)
	
	if (mousePos.x < position.x):
		currentGun.visuals.flip_v = true
		$Sprite.flip_h = true
	else:
		currentGun.visuals.flip_v = false
		$Sprite.flip_h = false
	
	super._physics_process(delta)
	#position = Vector2(0,0)
	#move_and_slide()
	pass
