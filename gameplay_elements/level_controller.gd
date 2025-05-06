class_name LevelController extends Node

@export var score_per_collision: int = 100
@export var try_again_button: Button = null
@export var failed_score_counter: RichTextLabel = null
@export var failed_bricks_broken_counter: RichTextLabel = null

var total_score: int = 0
var running_score: int = 0
var bricks_broken: int = 0

func _ready() -> void:
	$"../LevelCompleteUi".visible = false
	$"../LevelFailedUi".visible = false
	$"../Ball".brick_collide.connect(_on_ball_brick_collide)
	$"../Ball".paddle_collide.connect(_on_ball_paddle_collide)
	$"../KillZone".ball_destroyed.connect(_on_ball_destroyed)
	try_again_button.pressed.connect(_on_try_again_pressed)

func _on_ball_brick_collide(layer: TileMapLayer, collision_point: Vector2) -> void:
	update_score_and_bricks_counters()
	instantiate_flavor(collision_point)
	
	if check_level_complete(layer):
		level_complete()

func _on_ball_paddle_collide():
	running_score = 0

func _on_ball_destroyed():
	$"../LevelFailedUi".visible = true
	$"../OverlayUi".visible = false
	
func _on_try_again_pressed() -> void:
	LevelLoader.reload_level()

func update_score_and_bricks_counters() -> void:
	running_score += score_per_collision
	total_score += running_score
	bricks_broken += 1
	$"../OverlayUi/MarginContainer/HBoxContainer/ScoreCounter".text = str(total_score)
	failed_score_counter.text = str(total_score)
	failed_bricks_broken_counter.text = str(bricks_broken)
	
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
	$"../KillZone/CollisionShape2D".disabled = true
	SaveController.save_score_if_new_best(LevelLoader.loaded_level_name, total_score)
	
func _return_to_level_select() -> void:
	get_parent().queue_free()
	var menu_ui: Node = load("res://ui/menu_ui.tscn").instantiate()
	get_tree().root.add_child(menu_ui)
	menu_ui.get_node("LevelSelect").visible = true
