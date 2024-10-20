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
const TANK_DYNAMITE = preload("res://Scenes/Prefabs/Projectiles/TankDynamite.tscn")
const TANK_SHOT = preload("res://Scenes/Prefabs/Projectiles/TankShot.tscn")
@onready var trackDamageArea: DamageArea = $TrackDamageArea
@onready var explosionThrower: Node2D = $ExplosionThrower
@onready var gun_charge: Sprite2D = $Gun/GunCharge
@export var gunChargeSprites: Array[Texture]

var jeffery: Jeffery

var gunCharge: int
var gunCooldown: float

var waitTimer: float
var leftOrRight: bool
var moveDirection: bool
var speed: int = 200
var gameProgress: int

func _ready() -> void:
	super._ready()
	for child in get_tree().root.get_child(0).get_children():
		if child is Jeffery:
			jeffery = child
	state = 0
	gameProgress = gamemanager.piecesGotten
	health += 10 * gameProgress
	speed += 50 * gameProgress
	pass

func setKnockback(x:float, y:float):
	pass

func spawnDynamite() -> void:
	for x in range(gameProgress + 2):
		var d = TANK_DYNAMITE.instantiate()
		
		d.position = explosionThrower.global_position
		d.rotation_degrees = -80 - ((20.0 / (gameProgress+1.0)) * x)
		
		(d as Bullet).velocity += randf_range(-5,5)
		
		owner.add_child(d)
		d.owner = owner
		

func resetGunState() -> void:
	gunState = 0

func aiLogic(delta: float) -> void:
	
	if (jeffery == null) :
		return
	#setMovement(movement.x, 0)
	
	var hasJefferySwitchedSides = ((jeffery.position.x - position.x < 0) && leftOrRight) || ((jeffery.position.x - position.x > 0) && !leftOrRight)
	
	match (gunState): 
		0:
			if (hasJefferySwitchedSides) :
				leftOrRight = !leftOrRight
			
			if (hasJefferySwitchedSides) :
				if (leftOrRight) :
					hatchAnims.play("HatchRotate")
					gun_charge.position = Vector2(215, 13)
					gunCooldown = 0.75
				else :
					hatchAnims.play("HatchRotateBack")
					gun_charge.position = Vector2(-215, 13)
					gunCooldown = 0.75
			
			if (jeffery.global_position.y - gun.global_position.y > 40) :
				gun.rotation_degrees = -7.5 if (gunSprite.flip_h) else 7.5
			else:
				gun.rotation_degrees = 0
			
			if (gunCooldown > 0) :
				gunCooldown -= delta
			
			if (gunCooldown <= 0):
				if (position.distance_to(jeffery.position) < 400):
					gunState = 1
				else:
					gunCharge += 1
					gunCooldown = 2.1 / (gameProgress + 1.0)
					if (gunCharge >= 4) :
						
						gunCooldown = 2
						gunCharge = 0
						var d = TANK_SHOT.instantiate()
						d.position = gun_charge.global_position
						d.rotation_degrees = (0 if (leftOrRight) else 180) + gun.rotation_degrees
						owner.add_child(d)
						d.owner = owner
						
					gun_charge.texture = gunChargeSprites[gunCharge]
			
		1:
			$DynamiteHatch.flip_h = !leftOrRight
			hatchAnims.play("DynamiteThrow")
			gunState = 2
			gunCooldown = 1
	
	
	waitTimer -= delta
	
	match(state):
		0:
			
			if (waitTimer <= 0):
				state = randi_range(1, 2)
				
				trackDamageArea.process_mode = Node.PROCESS_MODE_INHERIT
				
				print(position.distance_to(jeffery.position))
				
				waitTimer = 1
				moveDirection = !leftOrRight if (position.distance_to(jeffery.position) < 550) else leftOrRight
			
			pass
		1:
			
			if (moveDirection) :
				setMovement(speed, movement.y)
				#print("Going Right")
				anims.play("MoveTracks")
			else:
				setMovement(-speed, movement.y)
				#print("Going Left")
				anims.play_backwards("MoveTracks")
			
			if (waitTimer <= 0) :
				backToIdle(0.5)
			
			
			pass
		2:
			
			if (moveDirection) :
				setMovement(speed * 3, movement.y)
				#print("Charging Right")
				anims.play("TrackCharge")
			else:
				setMovement(-speed * 3, movement.y)
				#print("Charging Left")
				anims.play_backwards("TrackCharge")
			
			if (waitTimer <= 0) :
				backToIdle(1)
			
			pass
	
	pass

func backToIdle(waittime: float) -> void:
	waitTimer = waittime
	anims.play("RESET")
	state = 0
	trackDamageArea.process_mode = Node.PROCESS_MODE_DISABLED
