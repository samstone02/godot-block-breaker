class_name LevelLoader extends Node

var loaded_level: String = ""
var loaded_level_path: String = ""

func _load_level(level_name: String) -> void:
	var level: Node = load("res://levels/" + level_name + ".tscn").instantiate()
	get_tree().root.get_node("MenuUi").visible = false
	get_tree().root.add_child(level)
	
	loaded_level = level.name
	loaded_level_path = "res://levels/" + level_name + ".tscn"

func reload_level() -> void:
	get_tree().root.get_node(loaded_level).queue_free()
	var level: Node = load(loaded_level_path).instantiate()
	get_tree().root.add_child(level)
	
	# since the level still exists at this point, the new instance will have a generated
	# name rather than the name of the level.
	# reassign the name so that we can correctly find it on the next call to reload_level
	loaded_level = level.name
