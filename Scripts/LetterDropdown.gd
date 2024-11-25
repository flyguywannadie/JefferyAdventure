extends Node2D

var time : float

func _ready() -> void:
	#for child in get_children():
		#(child as Node2D).position.y = -1000
	pass

func _process(delta: float) -> void:
	time += delta
	
	for child in get_children():
		var oldY = (child as Node2D).position.y
		(child as Node2D).position.y = lerpf((child as Node2D).position.y,oldY + (5.0 * cos(time * 2.0 + (child as Node2D).position.x)), 2 * delta)

func _input(event: InputEvent) -> void:
	if (event.is_action("jef_shoot") && $"../TitleSequence".is_playing()) :
		$"../TitleSequence".play("RESET")
