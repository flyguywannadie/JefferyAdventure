extends Boss

#states reference
# 0 - idle/deciding
# 1 - Walking side to side
# 2 - Charge at player
# 3 - Charge Gun

# gun states reference
# 0 - Looking at player
# 1 - throwing dynamite

var gunState: int

@onready var gun: Node2D = $Gun
@onready var hatchSprite: Sprite2D = $TankHatch
@onready var gunSprite: Sprite2D = $Gun/TankGun
@export var hatchAnims: AnimationPlayer

@onready var trackDamageArea: DamageArea = $TrackDamageArea
@onready var explosionThrower: Node2D = $ExplosionThrower
@onready var gun_charge: Sprite2D = $Gun/GunCharge
@export var gunChargeSprites: Array[Texture]

var gunCharge: int
var gunCooldown: float

var leftOrRight: bool
var moveDirection: bool
var speed: int = 200

func _ready() -> void:
	super._ready()
	
	state = 0
	gameProgress = GameManager.piecesGotten
	health += 10 * gameProgress
	speed += 50 * gameProgress

func setKnockback(x:float, y:float):
	pass

func spawnDynamite() -> void:
	spawnProjectile(explosionThrower.global_position, -90, 0, gameProgress + 2)

func resetGunState() -> void:
	gunState = 0

func aiLogic(delta: float) -> void:
	
	if (jeffery == null) :
		return
	
	gun_charge.material.set("shader_parameter/size", gunCooldown)
	
	var hasJefferySwitchedSides = ((jeffery.position.x - position.x < 0) && leftOrRight) || ((jeffery.position.x - position.x > 0) && !leftOrRight)
	
	if (gunCooldown > 0) :
		gunCooldown -= delta
	
	# gun state chooser
	match (gunState): 
		0: # look at player and charge
			if (hasJefferySwitchedSides) :
				leftOrRight = !leftOrRight
			
			if (hasJefferySwitchedSides) :
				if (leftOrRight) :
					hatchAnims.play("HatchRotate")
					gun_charge.position = Vector2(215, 13)
				else :
					hatchAnims.play("HatchRotateBack")
					gun_charge.position = Vector2(-215, 13)
				gunCooldown = 0.75
			
			var jefferyOffset = jeffery.global_position - gun.global_position;
			gun.rotation_degrees = rad_to_deg(atan2(jefferyOffset.y, abs(jefferyOffset.x)))
			gun.rotation_degrees = clamp(gun.rotation_degrees,-7.5,7.5)
			if (!leftOrRight) :
				gun.rotation_degrees = -gun.rotation_degrees
			
			if (gunCooldown <= 0):
				if (position.distance_to(jeffery.position) < 450):
					gunState = 1
				else:
					gunCharge += 1
					gunCooldown = 2.1 / (gameProgress + 1.0)
					if (gunCharge >= 4) :
						gunState = 3
						gunCooldown = 0.3
					else:
						gun_charge.texture = gunChargeSprites[gunCharge]
		1: # throw dynamite
			$DynamiteHatch.flip_h = !leftOrRight
			hatchAnims.play("DynamiteThrow")
			gunState = -1
			gunCooldown = 1
		3: # Shooting Gun Delay
			if (gunCooldown <= 0):
				gunCooldown = 2
				gunCharge = 0
				spawnProjectile(gun_charge.global_position, (0 if (leftOrRight) else 180) + gun.rotation_degrees, 1)
				gunState = 0
				gun_charge.texture = gunChargeSprites[gunCharge]
	
	# tank track state chooser
	match(state):
		0: # idle state
			if (stateTimer <= 0):
				state = randi_range(1, 2)
				
				trackDamageArea.process_mode = Node.PROCESS_MODE_INHERIT
				
				print(position.distance_to(jeffery.position))
				
				stateTimer = 1
				moveDirection = !leftOrRight if (position.distance_to(jeffery.position) < 550) else leftOrRight
		1: # moving state
			if (moveDirection) :
				setMovement(speed, movement.y)
				#print("Going Right")
				anims.play("MoveTracks")
			else:
				setMovement(-speed, movement.y)
				#print("Going Left")
				anims.play_backwards("MoveTracks")
			
			if (stateTimer <= 0) :
				backToIdle(0.5)
		2: # Charging state
			if (moveDirection) :
				setMovement(speed * 3, movement.y)
				#print("Charging Right")
				anims.play("TrackCharge")
			else:
				setMovement(-speed * 3, movement.y)
				#print("Charging Left")
				anims.play_backwards("TrackCharge")
			
			if (stateTimer <= 0) :
				backToIdle(1)
	
	super.aiLogic(delta)

func backToIdle(waittime: float) -> void:
	stateTimer = waittime
	anims.play("RESET")
	state = 0
	trackDamageArea.process_mode = Node.PROCESS_MODE_DISABLED
