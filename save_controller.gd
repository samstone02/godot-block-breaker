extends Node

func _ready() -> void:
	initialize_save()

func initialize_save() -> void:
	if FileAccess.file_exists("user://save.json"):
		return
	
	var data := {
		"levels": {},
	}
	
	var json_string := JSON.stringify(data)
	var access := FileAccess.open("user://save.json", FileAccess.WRITE)

	access.store_pascal_string(json_string)
	access.close()

func save_score_if_new_best(level_name: String, new_high_score: int) -> void:
	var read_access := FileAccess.open("user://save.json", FileAccess.READ)
	var save_data: Dictionary = JSON.parse_string(read_access.get_pascal_string())
	
	if not save_data["levels"].has(level_name):
		save_data["levels"][level_name] = {}
	
	if save_data["levels"][level_name].has("high_score") && save_data["levels"][level_name]["high_score"] > new_high_score:
		return
	
	save_data["levels"][level_name]["high_score"] = new_high_score
	var save_string: String = JSON.stringify(save_data)
	read_access.close()
	
	var write_access := FileAccess.open("user://save.json", FileAccess.WRITE)
	write_access.store_pascal_string(save_string)
	write_access.close()

func get_level_high_score(level_name: String) -> int:
	var access: FileAccess = FileAccess.open("user://save.json", FileAccess.READ)
	var save_data: Dictionary = JSON.parse_string(access.get_pascal_string())
	
	if not save_data["levels"].has(level_name) || not save_data["levels"][level_name].has("high_score"):
		return 0
	
	return save_data.levels[level_name].high_score
