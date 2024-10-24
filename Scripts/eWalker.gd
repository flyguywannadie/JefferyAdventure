extends Enemy
class_name Walker

#states reference
#0 = idle
#1 = walking

var walkDirection: bool = true

var walkOffEdge: bool = false

func _ready() -> void:
	setIdleTimer()
	$Sprite2D.flip_h = !walkDirection
	super._ready()

func aiLogic(delta: float) -> void:
	match (state):
		0: # Idle State
			if (stateTimer <= 0):
				setWalkTimer()
		1: # Walking State
			if (is_on_wall()):
				#print("hit wall")
				walkDirection = !walkDirection
			
			visuals.flip_h = !walkDirection
			
			if (walkDirection) :
				setMovement(200, movement.y)
			else :
				setMovement(-200, movement.y)
			
			#if(is_on_ceiling() && is_on_floor()):
				#setMovement(0,movement.y)
				#setIdleTimer()
			
			if (stateTimer <= 0):
				setIdleTimer()
	
	super.aiLogic(delta)

func setKnockback(x: float, y: float) -> void:
	
	if ((walkDirection && sign(x) == -1) || (!walkDirection && sign(x) == 1)):
		walkDirection = !walkDirection
		pass
	
	super.setKnockback(x,y)
	pass

func hitStunDone() -> void:
	setIdleTimer()
	pass

func takeDamage(damage: int):
	audioPlayer.play()
	anims.play("Hurt")
	SetHitStun(0.5)
	super.takeDamage(damage)

func setIdleTimer() -> void:
	stateTimer = randf_range(-2.0, 1.5)
	if (stateTimer < 0) :
		setWalkTimer()
	else:
		setMovement(0,movement.y)
		walkDirection = (randi() % 2 == 1)
		state = 0
		anims.play("Idle")

func setWalkTimer() -> void:
	stateTimer = randf_range(1.0, 3.0)
	state = 1
	anims.play("Walk")
