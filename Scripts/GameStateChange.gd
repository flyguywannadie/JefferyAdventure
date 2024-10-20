extends Node2D
class_name GameChange

enum Condition {CONTAINS, NOT_CONTAINS, EQUALS}
@export var condition: Condition
@export var expectedGameState: String = ""

func CheckCondition(gameState: String) -> void:
	
	var shouldshow: bool = false
	
	match (condition):
		Condition.CONTAINS:
			shouldshow = gameState.contains(expectedGameState)
			pass
		Condition.NOT_CONTAINS:
			shouldshow = !gameState.contains(expectedGameState)
			pass
		Condition.EQUALS:
			shouldshow = gameState == expectedGameState
			pass
	
	if (!shouldshow) :
		queue_free()
	
	pass
