extends Node2D
class_name Weapon

@export var inputAction: String = "jef_shoot"
@export var damage: int = 1
var cooldown: float = 1
@export var COOLDOWNSTART: float = 1
var readyUse: bool = true
@export var visuals: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cooldown = COOLDOWNSTART
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!readyUse):
		cooldown -= delta
		if(cooldown<= 0):
			readyUse = true
			cooldown = COOLDOWNSTART
	pass

func _input(event: InputEvent) -> void:
	if(readyUse && event.is_action(inputAction)):
		if (Input.is_action_just_pressed(inputAction)) :
			onUse()
#		if (Input.is_action_pressed(inputaction)) :
#			holdUse()
		if (Input.is_action_just_released(inputAction)) :
			releaseUse()
	pass

func startCooldown() -> void:
	readyUse = false
	pass

func onUse() -> void:
	pass

func holdUse() -> void:
	pass

func releaseUse() -> void:
	pass
