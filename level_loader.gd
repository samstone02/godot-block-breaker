class_name LevelLoader extends Node

var loaded_level: String = ""
var loaded_level_path: String = ""

func _load_level(level_name: String) -> void:
	print("Loading level: " + level_name)
	
	var level: Node = load("res://levels/" + level_name + ".tscn").instantiate()
	get_tree().root.get_node("MenuUi").visible = false
	get_tree().root.add_child(level)
	
	loaded_level = level.name
	loaded_level_path = "res://levels/" + level_name + ".tscn"

func reload_level() -> void:
	print("reloading level: " + loaded_level)
	get_tree().root.get_node(loaded_level).free()
	var level: Node = load(loaded_level_path).instantiate()
	get_tree().root.add_child(level)
