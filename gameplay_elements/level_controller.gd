class_name LevelController extends Node

func _ready() -> void:
	$"../LevelCompleteUi".visible = false
	$"../Ball".brick_collide.connect(_on_brick_collide)

func _on_brick_collide(collision: KinematicCollision2D) -> void:
	var collider = collision.get_collider()
	if collider is not TileMapLayer:
		print("The collision object must be a TileMapLayer")
		return
		
	var layer: TileMapLayer = collider
	if check_level_complete(layer):
		level_complete()
		
func check_level_complete(layer: TileMapLayer) -> bool:
	var used_cells: Array = layer.get_used_cells()
	for cell in used_cells:
		if layer.get_cell_atlas_coords(cell) != BrickAtlasCoords.wall:
			return false
	return true

func level_complete() -> void:
	$"../LevelCompleteUi".visible = true
	
func _return_to_level_select() -> void:
	get_parent().queue_free()
	get_tree().root.get_node("MenuUi").visible = true
