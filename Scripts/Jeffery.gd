extends Character
class_name Jeffery

var test: int = 10
@export var speed: float = 200
@export var jumpPower: float = 1400
var jumpTimer: float
var cayoteTime: int = 3
var onGround: bool = true

const TEST_GUN = preload("res://Scenes/Prefabs/Weapons/TestGun.tscn")
@onready var gun_holder: Node2D = $Node2D/GunArm/GunHolder
@onready var GunArm: Node2D = $Node2D/GunArm
var currentGun: Weapon

const TEST_SWORD = preload("res://Scenes/Prefabs/Weapons/TestSword.tscn")
@onready var sword_holder: Node2D = $Node2D/SwordArm
var currentSword: Weapon

@onready var anims: AnimationPlayer = $Node2D/AnimationPlayer

var hitStun: float = 0
var iLength: float = 0

var flipDir: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	
	GameManager.SetJeffery(self)
	
	#create base gun
	var gun = TEST_GUN.instantiate()
	evolveGun(gun)
	
	#create base sword
	var sword = TEST_SWORD.instantiate()
	evolveSword(sword)
	
	pass

func _input(event: InputEvent) -> void:
	
	
	
	pass

func _physics_process(delta: float) -> void:	
	if (iLength > 0) :
		
		iLength -= delta
		
		visuals.visible = !visuals.visible
		
		if (iLength <= 0):
			collision_layer = 1
			visuals.visible = true
		
		currentGun.visuals.visible = visuals.visible
		currentSword.visuals.visible = visuals.visible
		$Node2D/GunArm/GunArmSprite.visible = visuals.visible
	
	if (hitStun > 0) :
		hitStun -= delta
		if (hitStun <= 0) :
			enableWeapons()
			anims.play("RESET")
		super._physics_process(delta)
		return
	
	var sideVelocity: float = 0
	
	if (Input.is_action_pressed("jef_left")):
		sideVelocity += -speed
	
	if (Input.is_action_pressed("jef_right")):
		sideVelocity += speed
	
	setMovement(sideVelocity, movement.y)
	
	if (!is_on_floor() && onGround):
		cayoteTime -= 1
		if (cayoteTime < 0):
			onGround = false
	if (cayoteTime < 0 && is_on_floor()):
		cayoteTime = 3
		onGround = true
	
	if (Input.is_action_just_pressed("jef_Jump") && onGround):
		onGround = false
		cayoteTime = -1
		addMovement(0,-jumpPower/1.5)
		jumpTimer = 0.15
	if (Input.is_action_pressed("jef_Jump") && jumpTimer > 0):
		addMovement(0,-jumpPower/20.0)
		jumpTimer -= delta
	if (Input.is_action_just_released("jef_Jump")):
		jumpTimer = 0
	
	var mousePos = get_viewport().get_camera_2d().get_global_mouse_position()
	GunArm.look_at(mousePos)
	
	$Node2D.scale.x = -1 if mousePos.x < position.x else 1
	
	if (sideVelocity != 0):
		if (sideVelocity > 0) :
			if ($Node2D.scale.x == 1):
				anims.play("Walk")
			else:
				anims.play_backwards("Walk")
		else :
			if ($Node2D.scale.x == 1):
				anims.play_backwards("Walk")
			else:
				anims.play("Walk")
	else:
		anims.play("Idle")
	
	super._physics_process(delta)
	pass

func takeDamage(damage: int):
	anims.play("Hurt")
	audioPlayer.play()
	hitStun = 0.33
	iLength = 1.5
	collision_layer = 64
	disableWeapons()
	setKnockback(-600 * $Node2D.scale.x, -500)
	super.takeDamage(damage)

func Reset() -> void:
	hitStun = 0;
	
	setMovement(0,0)
	setKnockback(0,0)
	
	audioPlayer.stop()
	
	visuals.visible = true
	currentGun.visuals.visible = visuals.visible
	currentSword.visuals.visible = visuals.visible
	$Node2D/GunArm/GunArmSprite.visible = visuals.visible
	
	collision_layer = 1
	
	enableWeapons()
	anims.play("RESET")

func _die():
	print("START DEATH")
	
	iLength = 1.5
	GameManager.JefferyDie()
	
	pass

func disableWeapons() -> void:
	currentGun.enabled = false;
	currentSword.enabled = false;
	pass

func enableWeapons() -> void:
	currentGun.enabled = true;
	currentSword.enabled = true;
	pass

func evolveGun(gun: Node) -> void:
	gun_holder.add_child(gun)
	gun.owner = $"."
	currentGun = gun as Weapon
	currentGun.OnCreate()
	currentGun.KnockbackJeffery.connect(setKnockback)

func evolveSword(sword: Node) -> void:
	sword_holder.add_child(sword)
	sword.owner = $"."
	currentSword = sword as Weapon
	currentSword.OnCreate()
	currentSword.KnockbackJeffery.connect(setKnockback)

func EvolveWeapon(gunorsowrd: bool, piece: String) -> void:
	
	if (gunorsowrd) :
		var gun
		match(piece):
			"d":
				if (currentGun.dEvo == null) :
					return
				gun = currentGun.dEvo.instantiate()
			"c":
				if (currentGun.cEvo == null) :
					return
				gun = currentGun.cEvo.instantiate()
			"f":
				if (currentGun.fEvo == null) :
					return
				gun = currentGun.fEvo.instantiate()
			_:
				return
		currentGun.queue_free()
		evolveGun(gun)
	else:
		var sword
		match(piece):
			"d":
				if (currentSword.dEvo == null) :
					return
				sword = currentSword.dEvo.instantiate()
			"c":
				if (currentSword.cEvo == null) :
					return
				sword = currentSword.cEvo.instantiate()
			"f":
				if (currentSword.fEvo == null) :
					return
				sword = currentSword.fEvo.instantiate()
			_:
				return
		currentSword.queue_free()
		evolveSword(sword)
	pass
