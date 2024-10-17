extends Boss


#states reference
# 0 - idle/deciding
# 1 - Walking side to side
# 2 - Charge at player

@onready var gun: Node2D = $Gun
@onready var hatchSprite: Sprite2D = $TankHatch
@onready var gunSprite: Sprite2D = $Gun/TankGun
@export var hatchAnims: AnimationPlayer

@onready var trackDamageArea: DamageArea = $TrackDamageArea

var jeffery: Jeffery

var gunCharge: int

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

func aiLogic(delta: float) -> void:
	
	if (jeffery == null) :
		return
	#setMovement(movement.x, 0)
	
	var hasJefferySwitchedSides = ((jeffery.position.x - position.x < 0) && leftOrRight) || ((jeffery.position.x - position.x > 0) && !leftOrRight)
	
	if (hasJefferySwitchedSides) :
		leftOrRight = !leftOrRight
		
		if (leftOrRight) :
			hatchAnims.play("HatchRotate")
		else :
			hatchAnims.play("HatchRotateBack")
	
	waitTimer -= delta
	
	match(state):
		0:
			
			if (waitTimer <= 0):
				state = randi_range(1, 2)
				
				trackDamageArea.process_mode = Node.PROCESS_MODE_INHERIT
				
				waitTimer = 1
				moveDirection = leftOrRight
				if (state == 1) :
					moveDirection = randi_range(0,1) == 0
			
			pass
		1:
			
			if (moveDirection) :
				setMovement(speed, movement.y)
				print("Going Right")
				anims.play("MoveTracks")
			else:
				setMovement(-speed, movement.y)
				print("Going Left")
				anims.play_backwards("MoveTracks")
			
			if (waitTimer <= 0) :
				backToIdle(0.5)
			
			
			pass
		2:
			
			if (moveDirection) :
				setMovement(speed * 3, movement.y)
				print("Charging Right")
				anims.play("TrackCharge")
			else:
				setMovement(-speed * 3, movement.y)
				print("Charging Left")
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
