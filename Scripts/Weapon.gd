extends Node2D
class_name Weapon

@export var inputAction: String = "jef_shoot"
var cooldown: float = 1
@export var COOLDOWNLENGTH: float = 1
var readyUse: bool = true
var pressed: bool = false
@export var visuals: Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cooldown = COOLDOWNLENGTH
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if (!readyUse):
		cooldown -= delta
		if(cooldown <= 0):
			endCooldown()
			readyUse = true
			cooldown = COOLDOWNLENGTH
	
	if (pressed):
		onHold()
	
	pass

func _input(event: InputEvent) -> void:
	if(readyUse && event.is_action(inputAction)):
		if (Input.is_action_just_pressed(inputAction)) :
			onUse()
			pass
		if (Input.is_action_just_released(inputAction)) :
			onRelease()
			pass
	pass

func startCooldown() -> void:
	#print("cooldown started ", COOLDOWNLENGTH)
	readyUse = false
	pass

func endCooldown() -> void:
	#print("end of cooldown")
	pass

func onUse() -> void:
	#print("on click use")
	pressed = true
	pass

func onHold() -> void:
	#print("on hold use")
	pass

func onRelease() -> void:
	#print("on release use")
	pressed = false
	pass
