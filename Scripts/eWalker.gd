extends Enemy
class_name Walker

#states reference
#0 = idle
#1 = walking

var walkDirection: bool = true

var walkOffEdge: bool = false

var idleTimer: float = 1.0
var walkTimer: float = 2.0

func _ready() -> void:
	setIdleTimer()
	$Sprite2D.flip_h = !walkDirection
	super._ready()

func aiLogic(delta: float) -> void:
	match (state):
		0:
			idleTimer -= delta
			
			if (idleTimer <= 0):
				setWalkTimer()
			
			pass
		1:
			if (is_on_wall()):
				#print("hit wall")
				walkDirection = !walkDirection
			$Sprite2D.flip_h = !walkDirection
			
			if (walkDirection) :
				setMovement(200, movement.y)
			else :
				setMovement(-200, movement.y)
			
			walkTimer -= delta
			
			if (walkTimer <= 0):
				setIdleTimer()
			
			pass

func setKnockback(x: float, y: float) -> void:
	
	if ((walkDirection && sign(x) == -1) || (!walkDirection && sign(x) == 1)):
		walkDirection = !walkDirection
		pass
	
	super.setKnockback(x,y)
	pass

func setIdleTimer() -> void:
	idleTimer = randf_range(-2.0, 1.5)
	if (idleTimer < 0) :
		idleTimer = 0
		setWalkTimer()
	else:
		setMovement(0,movement.y)
		walkDirection = (randi() % 2 == 1)
		state = 0
		anims.play("Idle")


func setWalkTimer() -> void:
	walkTimer = randf_range(1.0, 3.0)
	state = 1
	anims.play("Walk")
