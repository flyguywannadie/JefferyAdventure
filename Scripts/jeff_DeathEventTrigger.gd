extends jeff_EventTrigger
class_name jeff_DeathEventTrigger

@export var WhoWillDie: Character

func _physics_process(delta: float) -> void:
	if (WhoWillDie == null) :
		Activate()
