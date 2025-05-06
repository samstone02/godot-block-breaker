extends Node

var loaded_level_name: String = "" # the level name used for reference purposes
var loaded_node_name: String = "" # the node name used to reference the level node
var loaded_level_path: String = "" # the path to the level resource

func load_level(level_name: String) -> void:
	var level: Node = load("res://levels/" + level_name + ".tscn").instantiate()
	get_tree().root.get_node("MenuUi").queue_free()
	get_tree().root.add_child(level)
	
	loaded_level_name = level_name
	loaded_node_name = level.name
	loaded_level_path = "res://levels/" + level_name + ".tscn"

func reload_level() -> void:
	get_tree().root.get_node(loaded_node_name).queue_free()
	var level: Node = load(loaded_level_path).instantiate()
	get_tree().root.add_child(level)
	
	# since the level still exists at this point, the new instance will have a generated
	# name rather than the name of the level.
	# reassign the name so that we can correctly find it on the next call to reload_level
	loaded_node_name = level.name
