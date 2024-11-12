extends Enemy

var desiredPos: Vector2
var followOffset: Vector2

var whoIFollow: Character
@onready var mygun: Node2D = $Gun


func _ready() -> void:
	desiredPos = position
	whoIFollow = GameManager.jeffery
	followOffset = Vector2(0, -200)
	stateTimer = 2
	super._ready()

func ShootGun():
	state = 0
	stateTimer = 2
	$Gun/GUnAnims.play("idle")
	
	var p: PackedScene = load("res://Scenes/Prefabs/Projectiles/TankDynamite.tscn")
	var t = p.instantiate()
	
	t.global_position = $Gun/Shooter.global_position
	t.rotation_degrees = $Gun.rotation_degrees
		
	GameManager.projectileOwner.add_child(t)
	t.owner = GameManager.projectileOwner
	

func aiLogic(delta: float) -> void:
	super.aiLogic(delta)
	
	match (state):
		0:
			mygun.look_at(whoIFollow.position)
			if (stateTimer < 0) :
				stateTimer = 0.75
				state = 1
		1:
			if (stateTimer < 0) :
				$Gun/GUnAnims.play("Shoot")
				state = 2
				stateTimer = 0.5
		2: 
			if (stateTimer < 0):
				state = 0
				stateTimer = 0.5
				$Gun/GUnAnims.play("idle")
				
		
	
	desiredPos = whoIFollow.position + followOffset
	
	if (is_on_floor()) :
		setKnockback(0, -500)
	
	var toMove = (desiredPos - position)
	
	setMovement(toMove.x, toMove.y)

func hitStunDone() -> void:
	anims.play("Idle")
	super.hitStunDone()

func takeDamage(damage: int):
	SoundManager.PlaySound("Hurt2")
	$Gun/GUnAnims.play("idle")
	anims.play("Hurt")
	var knocked = (position - whoIFollow.position).normalized() * 1200
	setKnockback(knocked.x, knocked.y)
	SetHitStun(0.75)
	super.takeDamage(damage)
