extends Node2D
class_name jeff_EventTrigger

@export var oneTime: bool = false

@export var whoToCall : Array[jeff_EventCaller]

func Activate() -> void:
	for x in range(whoToCall.size()):
		if (whoToCall[x].whoICallTo == null) :
			print(x, " has no one to call")
		else:
			if (whoToCall[x].whoICallTo.has_method(whoToCall[x].functionToCall)) :
				whoToCall[x].whoICallTo.call(whoToCall[x].functionToCall)
				print("Event Has Occured")
				if (oneTime) :
					queue_free()
			else:
				print(whoToCall[x].whoICallTo.name, " does not have method ", whoToCall[x].functionToCall)
