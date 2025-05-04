class_name RunningScoreFlavor extends Node2D

@export var min_rotation_speed: float = 0.05
@export var max_rotation_speed: float = 0.15
@export var fall_speed: float = 100.0
@export var life_span_seconds: float = 1.5

var life: float
var rotation_speed: float = 0.0

func _ready() -> void:
	rotation_speed = randf() * (max_rotation_speed - min_rotation_speed) + min_rotation_speed
	if (randf() > 0.5):
		rotation_speed *= -1
	life = life_span_seconds

func _process(delta: float) -> void:
	life -= delta
	
	if (life < 0.0):
		queue_free()
		return
	
	var new_modulate = modulate
	new_modulate.a = life / life_span_seconds
	modulate = new_modulate
	
	global_position.y += fall_speed * delta
	rotate(rotation_speed * delta)
