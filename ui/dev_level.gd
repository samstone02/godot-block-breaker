extends Control

func _ready() -> void:
	if !OS.has_feature("editor"):
		queue_free()
