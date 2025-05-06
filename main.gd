extends Node2D

func _ready() -> void:
	var ui: Node = load("res://ui/menu_ui.tscn").instantiate()
	get_tree().root.add_child.call_deferred(ui)
