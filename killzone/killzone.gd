extends Area2D

func _ready() -> void:
	connect("body_entered", func(body):
		if body.name == "Ball":
			body.queue_free()
	)
