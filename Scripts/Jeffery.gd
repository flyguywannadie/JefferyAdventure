extends Character
class_name Jeffery

var test: int = 10
@export var speed: float = 200

const TEST_GUN = preload("res://Scenes/Prefabs/TestGun.tscn")
@onready var gun_holder: Node2D = $GunArm/GunHolder
var currentGun: Weapon

const TEST_SWORD = preload("res://Scenes/Prefabs/TestSword.tscn")
@onready var sword_holder: Node2D = $SwordArm
var currentSword: Weapon

@onready var anims: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	
	#create base gun
	var gun = TEST_GUN.instantiate()
	gun_holder.add_child(gun)
	gun.owner = $"."
	currentGun = gun as Weapon
	
	#create base sword
	var sword = TEST_SWORD.instantiate()
	sword_holder.add_child(sword)
	sword.owner = $"."
	currentSword = sword as Weapon
	
	pass

func _process(delta: float) -> void:
	
	var sideVelocity: float = 0
	
	if (Input.is_key_pressed(KEY_A)):
		sideVelocity += -speed
	
	if (Input.is_key_pressed(KEY_D)):
		sideVelocity += speed
	
	setMovement(sideVelocity, movement.y)
	
	if (Input.is_action_just_pressed("jef_Jump")):# && is_on_floor()):
		addMovement(0,-1400)
	
	var mousePos = get_viewport().get_camera_2d().get_global_mouse_position()
	$GunArm.look_at(mousePos)
	
	if (mousePos.x < position.x):
		currentGun.visuals.flip_v = true
		currentSword.visuals.flip_v = true
		currentSword.rotation_degrees = 180
		$Sprite.flip_h = true
	else:
		currentGun.visuals.flip_v = false
		currentSword.visuals.flip_v = false
		currentSword.rotation_degrees = 0
		$Sprite.flip_h = false
	
	
	if (sideVelocity != 0):
		if (mousePos.x < position.x) :
			if (sideVelocity > 0) :
				anims.play("WalkBackwards")
			else :
				anims.play("Walk")
		else :
			if (sideVelocity < 0) :
				anims.play("WalkBackwards")
			else :
				anims.play("Walk")
	else:
		anims.play("Idle")
	
	super._process(delta)
	
	pass

func getFacingDirection() -> bool:
	return $Sprite.flip_h

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	super._physics_process(delta)
	pass
