extends Character
class_name Enemy

@export var anims : AnimationPlayer
@export var state : int

@export var hitStun: float

func _ready() -> void:
	super._ready()

func _physics_process(delta: float) -> void:
	
	aiLogic(delta)
	
	if (hitStun > 0) :
		hitStun -= delta
		if (hitStun <= 0):
			hitStunDone()
	
	super._physics_process(delta)

func hitStunDone() -> void:
	pass

func aiLogic(delta: float) -> void:
	pass
