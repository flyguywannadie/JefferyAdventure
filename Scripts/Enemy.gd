extends Character
class_name Enemy

@export var anims : AnimationPlayer
@export var state : int

@export var hitStun: float
var hitstunAmount: float

func _ready() -> void:
	super._ready()

func _physics_process(delta: float) -> void:
	
	if (hitstunAmount > 0) :
		hitstunAmount -= delta
		if (hitstunAmount <= 0):
			hitStunDone()
	else:
		aiLogic(delta)
	
	super._physics_process(delta)

func hitStunDone() -> void:
	pass

func aiLogic(delta: float) -> void:
	pass
