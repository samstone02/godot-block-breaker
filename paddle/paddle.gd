extends StaticBody2D

@export var ball: Ball = null
@export var paddle_speed: float = 1.0
@export var ball_launch_speed: float = 1.0
@export var launch_angle_rotation_speed: float = 1.0

var ball_launched: bool = false

func _ready() -> void:
	$"../Ball".global_position = $LaunchPoint.global_position

func _process(delta: float) -> void:
	if ball != null && is_instance_valid(ball) && !ball.launched:
		if Input.is_action_pressed("ui_left"):
			$LaunchPoint.rotate(launch_angle_rotation_speed * -delta)
		if Input.is_action_pressed("ui_right"):
			$LaunchPoint.rotate(launch_angle_rotation_speed * delta)
		
		if Input.is_action_pressed("launch_ball"):
			$LaunchPoint.visible = false
			ball.launch(($LaunchPoint/TowardsPoint.global_position - $LaunchPoint.global_position).normalized() * ball_launch_speed)
		return
	
	if Input.is_action_pressed("ui_left"):
		position.x -= paddle_speed * delta
	if Input.is_action_pressed("ui_right"):
		position.x += paddle_speed * delta
