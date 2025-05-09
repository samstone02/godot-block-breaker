class_name Ball extends CharacterBody2D

@export var initial_velocity: float = 2500

signal brick_collide(TileMapLayer, Vector2i)
signal paddle_collide

var launched: bool = false
@onready var brickBreakAudioStreamPlayer: AudioStreamPlayer = $BrickBreakAudioStreamPlayer
@onready var wallCollideAudioStreamPlayer: AudioStreamPlayer = $WallCollideAudioStreamPlayer
@onready var paddleCollideAudioStreamPlayer: AudioStreamPlayer = $PaddleCollideAudioStreamPlayer

func _physics_process(delta: float) -> void:
	if !launched:
		return
	
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if not collision:
		return
		
	var obj = collision.get_collider()
	if obj.name == "Paddle":
		paddleCollideAudioStreamPlayer.play(0.0)
		var bounce_center = obj.get_node("BounceCenter").global_position
		velocity = (collision.get_position() - bounce_center).normalized() * velocity.length()
		paddle_collide.emit()
		return
	else:
		velocity = velocity.bounce(collision.get_normal())
		
		if obj is not TileMapLayer:
			return
		
		var tile_pos = collision.get_position() - collision.get_normal() #
		var cell_coords = obj.local_to_map(tile_pos - obj.position)
		var cell_atlas_coords = obj.get_cell_atlas_coords(cell_coords)
		
		if (cell_atlas_coords == BrickAtlasCoords.wall):
			wallCollideAudioStreamPlayer.play(0.0)
			return
		
		brickBreakAudioStreamPlayer.play(0.0)
		
		cell_atlas_coords = BrickAtlasCoords.decrement(cell_atlas_coords)			
		obj.set_cell(cell_coords, 0, cell_atlas_coords, 0)
		
		brick_collide.emit(obj, collision.get_position())

func launch(vel: Vector2):
	launched = true
	velocity = vel
