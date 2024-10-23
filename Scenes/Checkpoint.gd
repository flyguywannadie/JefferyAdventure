@tool extends Area2D
class_name Checkpoint

@export var shape2 : RectangleShape2D
@export var collisionPosition: Vector2
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	if (!Engine.is_editor_hint()) :
		setCollisionShape()

func _process(delta: float) -> void:
	if (Engine.is_editor_hint()) :
		setCollisionShape()

func setCollisionShape() -> void:
	collision_shape_2d.shape = shape2
	collision_shape_2d.position = collisionPosition

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	GameManager.currentCheckpoint = self
