extends Enemy

@export var speed: float = 300.0

var followOffset: Vector2
var followOffsetAngle: float = 1
var desiredOffsetAngle: float = 1
var angleSpeed: float = 1.5
@export var gunAngle: float = 1

@export var patrolPoints: Array[Node2D]
@export var currentPoint: int = 0
@export var goingDownTheList: bool

var whoIFollow: Character
@onready var mygun: Node2D = $Gun
@onready var jeffCheck: ShapeCast2D = $Gun/JefferyDetector

enum patrolType{ BACKANDFORTH, LOOP}
@export var patrol: patrolType

func _ready() -> void:
	#whoIFollow = GameManager.jeffery
	followOffset = Vector2(0, -300)
	$Gun.rotation_degrees = gunAngle if (gunAngle != 0) else 1
	#if (patrolPoints.size() > 0) :
		#global_position = patrolPoints[currentPoint].global_position
	super._ready()

func ShootGun():
	state = 0
	stateTimer = 3
	desiredOffsetAngle = deg_to_rad(randf_range(-sign(followOffsetAngle),sign(followOffsetAngle) * -90.0))
	$Gun/GUnAnims.play("idle")
	
	SoundManager.PlaySound("Shoot")
	
	var p: PackedScene = load("res://Scenes/Prefabs/Projectiles/TankDynamite.tscn")
	var t = p.instantiate()
	
	t.global_position = $Gun/Shooter.global_position
	t.rotation_degrees = $Gun.rotation_degrees
		
	GameManager.projectileOwner.add_child(t)
	t.owner = GameManager.projectileOwner
	

func aiLogic(delta: float) -> void:
	super.aiLogic(delta)
	
	if (!whoIFollow) :
		PatrolAI(delta)
	else :
		ChaseAI(delta)


func PatrolAI(delta: float) -> void:
	if (jeffCheck.is_colliding()) :
		whoIFollow = GameManager.jeffery
		print("Jeffery Seen!!")
		jeffCheck.enabled = false
		stateTimer = 1.5
		state = 0
		return
	
	if (abs(gunAngle + 90 - $Gun.rotation_degrees) < 2) :
		gunAngle = randf_range(-sign($Gun.rotation_degrees - 90) * 45.0, -sign($Gun.rotation_degrees - 90) * 100.0)
	
	$Gun.rotation_degrees = lerp($Gun.rotation_degrees, gunAngle + 90, delta)
	
	if (patrolPoints.size() <= 1) :
		setMovement(0, 0)
		return
	
	match (state):
		0:
			setMovement(0, 0)
			
			if (stateTimer <= 0) :
				match (patrol):
					patrolType.BACKANDFORTH:
						if (goingDownTheList) :
							currentPoint += 1
							if (currentPoint > patrolPoints.size() - 1) :
								currentPoint = patrolPoints.size() - 2
								goingDownTheList = false
						else :
							currentPoint -= 1
							if (currentPoint < 0) :
								currentPoint = 1
								goingDownTheList = true
					patrolType.LOOP:
						if (goingDownTheList) :
							currentPoint += 1
							if (currentPoint > patrolPoints.size() - 1) :
								currentPoint = 0
						else :
							currentPoint -= 1
							if (currentPoint < 0) :
								currentPoint = patrolPoints.size() - 1
				print(currentPoint)
				state = 1
		1:
			var toMove = (patrolPoints[currentPoint].global_position - global_position).normalized() * speed
			setMovement(toMove.x, toMove.y)
			if (global_position.distance_to(patrolPoints[currentPoint].global_position) < 50) :
				state = 0
				stateTimer = 1.5


func ChaseAI(delta: float) -> void:
	match (state):
		0:
			mygun.look_at(whoIFollow.global_position)
			if (stateTimer <= 0) :
				stateTimer = 1
				state = 1
		1:
			if (stateTimer <= 0) :
				$Gun/GUnAnims.play("Shoot")
				state = 2
		#2: # This state is not used as its functionality is handled in the ShootGun() function
			#if (stateTimer < 0):
				#state = 0
				#stateTimer = 0.5
				#$Gun/GUnAnims.play("idle")
	
	followOffsetAngle = lerpf(followOffsetAngle, desiredOffsetAngle, delta * angleSpeed)
	var desiredPos = whoIFollow.global_position + followOffset.rotated(followOffsetAngle)
	
	if (is_on_floor()) :
		SetHitStun(0)
	
	var toMove = (desiredPos - global_position)
	
	setMovement(toMove.x, toMove.y)


func hitStunDone() -> void:
	anims.play("Idle")
	if (state == 3) :
		var p: PackedScene = load("res://Scenes/Prefabs/Projectiles/Explosion.tscn")
		var t = p.instantiate()
		
		t.global_position = global_position
		
		GameManager.projectileOwner.add_child(t)
		t.owner = GameManager.projectileOwner
		super._die()
	$AudioStreamPlayer.play(randf())
	$Damage.process_mode = Node.PROCESS_MODE_INHERIT
	super.hitStunDone()

func _die() -> void:
	state = 3
	stateTimer = 2
	SetHitStun(2)

func takeDamage(damage: int):
	if (state == 3) :
		return
	match (randi_range(0,2)):
		0:SoundManager.PlaySound("MetalHit")
		1:SoundManager.PlaySound("MetalHit1")
		2:SoundManager.PlaySound("MetalHit2")
	$Damage.process_mode = Node.PROCESS_MODE_DISABLED
	$Gun/GUnAnims.play("idle")
	$AudioStreamPlayer.stop()
	anims.play("Hurt")
	if (!whoIFollow) :
		whoIFollow = GameManager.jeffery
	var knocked = (global_position - whoIFollow.global_position).normalized() * 600
	setKnockback(knocked.x, knocked.y)
	SetHitStun(0.75)
	super.takeDamage(damage)
