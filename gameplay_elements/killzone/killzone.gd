extends Area2D

signal ball_destroyed

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Ball":
		body.queue_free()
		ball_destroyed.emit()
