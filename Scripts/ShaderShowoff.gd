extends Node2D

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var go_away: Sprite2D = $"../GoAway"

var usedCells : Array[Vector2i]
var startingAngle : float
var changedAngle : float

func _ready() -> void:
	#var usedcells =
	usedCells = tile_map_layer.get_used_cells()
	startingAngle = tile_map_layer.get_cell_tile_data(usedCells[0]).material.get("shader_parameter/angle")


func _process(delta: float) -> void:
	tile_map_layer.get_cell_tile_data(usedCells[0]).material.set("shader_parameter/angle", abs(fmod(startingAngle + changedAngle, 360.0)))
	go_away.material.set("shader_parameter/angle", abs(fmod(startingAngle + changedAngle, 360.0)))
	
	if (Input.is_key_pressed(KEY_COMMA)) :
		changedAngle -= 60 * delta
	if (Input.is_key_pressed(KEY_PERIOD)) :
		changedAngle += 60 * delta
	if (Input.is_key_pressed(KEY_SLASH)) :
		changedAngle = 0
