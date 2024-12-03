extends Character
class_name Jeffery


# state reference
# 1 = 

var state: int = 0
@export var speed: float = 200
@export var jumpPower: float = 1400
var jumpTimer: float
var cayoteTime: int = 3
var onGround: bool = true
var crouching: bool = false

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
var hitboxSize: Vector2
var hitboxPos: Vector2
@onready var crouchCheck: ShapeCast2D = $KeepCrouchingCheck

@export var trySlide: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	
	hitboxSize = $StandingHitbox.shape.size
	print(hitboxSize)
	GameManager.SetJeffery(self)
	
	ResetWeapons()
	
	pass

func RemoveControl():
	state = 1
	disableWeapons()

func ReturnControl():
	state = 0
	enableWeapons()

func shouldBeCrouching() -> bool:
	# returns true if the player should be crouching
	#print(crouching)
	#print(crouchCheck.is_colliding())
	
	return crouching || crouchCheck.is_colliding()

func doneSlide() -> void:
	checkCrouch()
	trySlide = true
	pass

func checkCrouch() -> void:
	if (!shouldBeCrouching()) :
		crouching = false
		$StandingHitbox.shape.size = hitboxSize
		$StandingHitbox.position = hitboxPos
		set_collision_mask_value(8, true)
	else:
		crouching = true
		$StandingHitbox.shape.size = Vector2(hitboxSize.x, hitboxSize.y / 2)
		$StandingHitbox.position = hitboxPos + Vector2(0, hitboxSize.y / 4)

func _physics_process(delta: float) -> void:
	
	if (state == 1) :
		return
	
	if (crouching != Input.is_action_pressed("jef_down") && trySlide) :
		crouching = Input.is_action_pressed("jef_down")
		checkCrouch()
			
	
	if (health <= 0) :
		super._physics_process(delta)
		return
	
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
			#anims.play("RESET")
		super._physics_process(delta)
		return
	
	if (!is_on_floor() && onGround):
		if (!trySlide) :
			doneSlide()
		cayoteTime -= 1
		if (cayoteTime < 0):
			onGround = false
		else :
			if (Input.is_action_pressed("jef_Jump") && !Input.is_action_pressed("jef_down")):
				jump()
	if (cayoteTime < 0 && is_on_floor()):
		cayoteTime = int(Engine.get_frames_per_second()/10)
		onGround = true
		set_collision_mask_value(8, true)
		#doneSlide()
	
	if (Input.is_action_just_pressed("jef_slide") && trySlide) :
		addKnockback(speed * 2.0 * (sign(movement.x + $Node2D.scale.x)), 100)
		anims.play("RESET")
		anims.play("Slide")
		$StandingHitbox.shape.size = Vector2(hitboxSize.x, hitboxSize.y / 2)
		$StandingHitbox.position = hitboxPos + Vector2(0, hitboxSize.y / 4)
		trySlide = false
	
	if (Input.is_action_just_pressed("jef_Jump") && onGround && trySlide):
		if (Input.is_action_pressed("jef_down") || Input.is_action_just_pressed("jef_down")) :
			set_collision_mask_value(8, false)
		else:
			#doneSlide()
			jump()
	if (Input.is_action_pressed("jef_Jump") && jumpTimer > 0):
		addMovement(0,-jumpPower/19.0)
		jumpTimer -= delta
	if (Input.is_action_just_released("jef_Jump")):
		jumpTimer = 0
	
	var mousePos = get_viewport().get_camera_2d().get_global_mouse_position()
	GunArm.look_at(mousePos)
	
	$Node2D.scale.x = -1 if mousePos.x < position.x else 1
	
	
	var sideVelocity: float = 0
		
	if (trySlide) :	
		if (Input.is_action_pressed("jef_left")):
			sideVelocity += -speed
		
		if (Input.is_action_pressed("jef_right")):
			sideVelocity += speed
		
		if (crouching) :
			sideVelocity *= 0.5
			anims.play("CrouchIdle")
		else:
			if (sideVelocity != 0):
				if ((sideVelocity > 0 && $Node2D.scale.x == 1) || (sideVelocity < 0 && $Node2D.scale.x == -1)) :
					anims.play("Walk")
				else :
					anims.play_backwards("Walk")
			else:
				anims.play("Idle")
	
	setMovement(sideVelocity, movement.y)
	
	super._physics_process(delta)

func jump():
	onGround = false
	cayoteTime = -1
	addMovement(0,-jumpPower/1.5)
	jumpTimer = 0.15

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("jef_reset")) :
		ResetWeapons()
		Reset()
		global_position = GameManager.checkpoint.global_position
		GameManager.piecesGotten = 0
		GameManager.gameState = ""
	if (event.is_action_pressed("jef_die")) :
		takeDamage(10000)
	if (event.is_action_pressed("jef_heal")) :
		health = maxHealth
		

func takeDamage(damage: int):
	anims.play("Hurt")
	doneSlide()
	hitStun = 0.33
	iLength = 1.5
	collision_layer = 64
	disableWeapons()
	setKnockback(-600 * $Node2D.scale.x, -500)
	super.takeDamage(damage)
	SoundManager.PlaySound("jef_Hurt")

func Reset() -> void:
	hitStun = 0;
	
	health = maxHealth
	
	setMovement(0,0)
	setKnockback(0,0)
	
	visuals.visible = true
	currentGun.visuals.visible = visuals.visible
	currentSword.visuals.visible = visuals.visible
	$Node2D/GunArm/GunArmSprite.visible = visuals.visible
	
	doneSlide()
	
	enableWeapons()
	anims.play("RESET")
	ReturnControl()

func _die():
	#print("START DEATH")
	SoundManager.PlaySound("Death")
	iLength = 1.5
	GameManager.JefferyGameOver()
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

func ResetWeapons():
	#create base gun
	var gun = TEST_GUN.instantiate()
	if (currentGun != null) :
		currentGun.queue_free()
	evolveGun(gun)
	
	#create base sword
	var sword = TEST_SWORD.instantiate()
	if (currentSword != null) :
		currentSword.queue_free()
	evolveSword(sword)

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
