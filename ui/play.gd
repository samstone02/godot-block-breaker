extends Button

func _ready() -> void:
	pressed.connect(_pressed)

func _pressed() -> void:
	$"../../../LevelSelect".visible = true
