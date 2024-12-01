extends Enemy
class_name AngryWalker

#states reference
#0 = Walking
#1 = ReadyShoot

var facingDirection: int = 1
var movingDirection: int = 1
var jef : Jeffery
@onready var launcher: Node2D = $Launcher

@export var rocket: PackedScene

func _ready() -> void:
	jef = GameManager.GetJeffery()
	facingDirection = sign(jef.global_position.x - global_position.x)
	if (facingDirection > 0) :
		launcher.scale = Vector2(1,1)
		visuals.flip_h = false
	else :
		launcher.scale = Vector2(-1,1)
		visuals.flip_h = true
	super._ready()

func aiLogic(delta: float) -> void:
	var jefDistance = jef.global_position.distance_to(global_position)
	
	if (jefDistance > 750) :
		movingDirection = sign(jef.global_position.x - global_position.x)
		state = 0
		anims.play("Walk")
	elif (jefDistance < 550) :
		movingDirection = -sign(jef.global_position.x - global_position.x)
		state = 0
		anims.play("WalkBackwards")
		if (jefDistance < 300) :
			shootRocket()
	else :
		movingDirection = 0
		state = 1
		anims.play("Idle")
	
	facingDirection = sign(jef.global_position.x - global_position.x)
	if (jef.global_position.y > global_position.y || jefDistance < 400) :	
		launcher.look_at(jef.global_position)
		if (facingDirection > 0) :
			launcher.scale = Vector2(1,1)
			if (jefDistance < 400):
				launcher.rotate(deg_to_rad(15))
			#launcher.rotate(deg_to_rad(15))
		else :
			launcher.scale = Vector2(-1,1)
			launcher.rotate(deg_to_rad(180))
			if (jefDistance < 400):
				launcher.rotate(deg_to_rad(-15))
			#launcher.rotate(deg_to_rad(180-15))
	
	match (state):
		0: # Walking State
			if (stateTimer < 1.0) :
				stateTimer = 1.0
			setMovement(movingDirection * 200, movement.y)
			#if (is_on_wall()):
				#print("hit wall")
				#setMovement(0, movement.y)
			
			if (facingDirection > 0) :
				launcher.scale = Vector2(1,1)
				visuals.flip_h = false
			else :
				launcher.scale = Vector2(-1,1)
				visuals.flip_h = true
			
		1: # ReadyShoot state
			stateTimer -= delta
			if (stateTimer <= 0) :
				shootRocket()
			
	
	super.aiLogic(delta)

func shootRocket()  :
	setKnockback(-facingDirection * 500, 0)
	SetHitStun(1.0)
	
	var r = rocket.instantiate()
	r.rotation = launcher.global_rotation
	r.position = $Launcher/Bulletspawn.global_position
	GameManager.projectileOwner.add_child(r)
	r.owner = GameManager.projectileOwner
	
	anims.play("Shoot")
	SoundManager.PlaySound("TankShoot")
	stateTimer = 2.5

func hitStunDone() -> void:
	$Damage.process_mode = Node.PROCESS_MODE_INHERIT
	anims.play("RESET")
	pass

func _die() -> void:
	SoundManager.PlaySound("Death")
	super._die()

func takeDamage(damage: int):
	super.takeDamage(damage)
	if (hitstun <= 0) :
		match (randi_range(0,1)):
			0:SoundManager.PlaySound("Hurt3")
			1:SoundManager.PlaySound("Hurt4")
	anims.play("Hurt")
	$Damage.process_mode = Node.PROCESS_MODE_DISABLED
	SetHitStun(0.5)
