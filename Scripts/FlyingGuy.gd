extends Enemy

var desiredPos: Vector2
var followOffset: Vector2

var whoIFollow: Character
@onready var mygun: Node2D = $Gun


func _ready() -> void:
	desiredPos = global_position
	whoIFollow = GameManager.jeffery
	followOffset = Vector2(0, -200)
	stateTimer = 2
	super._ready()

func ShootGun():
	state = 0
	stateTimer = 2
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
	
	match (state):
		0:
			mygun.look_at(whoIFollow.global_position)
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
		
	
	desiredPos = whoIFollow.global_position + followOffset
	
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
	super.hitStunDone()

func _die() -> void:
	state = 3
	stateTimer = 2
	SetHitStun(2)

func takeDamage(damage: int):
	if (state == 3) :
		return
	if (hitstun <= 0) :
		match (randi_range(0,2)):
			0:SoundManager.PlaySound("MetalHit")
			1:SoundManager.PlaySound("MetalHit1")
			2:SoundManager.PlaySound("MetalHit2")
	$Gun/GUnAnims.play("idle")
	anims.play("Hurt")
	var knocked = (global_position - whoIFollow.global_position).normalized() * 1200
	setKnockback(knocked.x, knocked.y)
	SetHitStun(0.75)
	super.takeDamage(damage)
