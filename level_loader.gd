class_name LevelLoader extends Node

func _load_level(level_name: String) -> void:
	print("Loading level: " + level_name)
	
	var level: Node = load("res://levels/" + level_name + ".tscn").instantiate()
	get_tree().root.get_node("MenuUi").visible = false
	get_tree().root.add_child(level)
