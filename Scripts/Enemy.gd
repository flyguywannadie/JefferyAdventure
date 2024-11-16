extends Character
class_name Enemy

@export var anims : AnimationPlayer
@export var state : int

var hitstun: float
var stateTimer: float

@export var HitEffect: PackedScene

func _ready() -> void:
	super._ready()

func _physics_process(delta: float) -> void:
	
	if (hitstun > 0) :
		hitstun -= delta
		if (hitstun <= 0):
			hitStunDone()
	else:
		aiLogic(delta)
	
	super._physics_process(delta)

func SetHitStun(stun: float) -> void:
	hitstun = stun

func hitStunDone() -> void:
	pass

func aiLogic(delta: float) -> void:
	if (stateTimer > 0) :
		stateTimer -= delta
	pass

func spawnHitEffect() -> void:
	if (HitEffect != null):
		var he = HitEffect.instantiate()
		he.position = position
		owner.add_child(he)
		he.owner = owner

func takeDamage(damage: int):
	spawnHitEffect()
	super.takeDamage(damage)
