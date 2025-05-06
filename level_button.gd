class_name LevelButton extends Control

@export var level_name: String = ""
@export var high_score_label: Label = null

func _ready() -> void:
	var level_high_score: int = SaveController.get_level_high_score(level_name)
	high_score_label.text = str(level_high_score)

func _pressed() -> void:
	LevelLoader.load_level(level_name)
