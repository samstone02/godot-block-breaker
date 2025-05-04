class_name LevelController extends Node

@export var score_per_collision: int = 100

var total_score: int = 0
var running_score = 0

func _ready() -> void:
	$"../LevelCompleteUi".visible = false
	$"../Ball".brick_collide.connect(_on_ball_brick_collide)
	$"../Ball".paddle_collide.connect(_on_ball_paddle_collide)

func _on_ball_brick_collide(layer: TileMapLayer, collision_point: Vector2) -> void:
	update_score()
	instantiate_flavor(collision_point)
	
	if check_level_complete(layer):
		level_complete()

func _on_ball_paddle_collide():
	running_score = 0

func update_score() -> void:
	running_score += score_per_collision
	total_score += running_score
	$"../OverlayUi/MarginContainer/HBoxContainer/ScoreCounter".text = str(total_score)
	
func instantiate_flavor(collision_point: Vector2) -> void:
	var flavor: RunningScoreFlavor = load("res://gameplay_elements/running_score_flavor.tscn").instantiate()
	get_tree().root.add_child(flavor)
	flavor.global_position = collision_point
	flavor.get_node("RichTextLabel").text = str(running_score)
	
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
