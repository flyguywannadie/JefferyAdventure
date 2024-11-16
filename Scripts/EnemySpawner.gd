extends Node2D
class_name EnemySpawner

@export var enemyToSpawn: PackedScene

func SpawnEnemy() -> void:
	var t = enemyToSpawn.instantiate()
	t.position = global_position
	owner.add_child(t)
	t.owner = owner
