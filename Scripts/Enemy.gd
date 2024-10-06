extends Character
class_name Enemy

@export var anims : AnimationPlayer
@export var state : int

func _ready() -> void:
	super._ready()

func _physics_process(delta: float) -> void:
	
	aiLogic(delta)
	
	super._physics_process(delta)

func aiLogic(delta: float) -> void:
	pass
