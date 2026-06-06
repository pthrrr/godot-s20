extends CharacterBody3D

@export var controls: Resource = null

var spawn_position: Vector3

func _ready():
	spawn_position = global_position
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	if event is InputEventMouseMotion and controls.player_index == 0:
		rotation_degrees.y -= event.relative.x * 0.2
		#get_node("Camera3D")
		#$Camera3D
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.2
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x, -80.0, 80.0
		)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
		
func _physics_process(delta):
	const SPEED = 5.5
	
	var input_direction_2D = Input.get_vector(
		controls.move_left, controls.move_right, controls.move_forward, controls.move_backward
	)
	var input_direction_3D = Vector3(
		input_direction_2D.x, 0.0, input_direction_2D.y
	)
	var direction = transform.basis * input_direction_3D
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	velocity.y -= 20.0 * delta
	if Input.is_action_just_pressed(controls.jump) and is_on_floor():
		velocity.y = 5
	elif Input.is_action_just_released(controls.jump) and velocity.y > 0.0:
		velocity.y = 0.0

	# Right stick camera control
	var look_x = Input.get_axis(controls.camera_left, controls.camera_right)
	var look_y = Input.get_axis(controls.camera_up, controls.camera_down)
	var stick_sensitivity = 3.5
	rotation_degrees.y -= look_x * stick_sensitivity
	%Camera3D.rotation_degrees.x -= look_y * stick_sensitivity
	%Camera3D.rotation_degrees.x = clamp(
		%Camera3D.rotation_degrees.x, -80.0, 80.0
	)

	move_and_slide()
	
	if Input.is_action_pressed(controls.shoot) and %Timer.is_stopped():
		shoot_bullet()

	if global_position.y < -35.0:
		global_position = spawn_position
		velocity = Vector3.ZERO

	
func shoot_bullet():
	const BULLET_3D = preload("uid://ceb27mcygqh27")
	var new_bullet = BULLET_3D.instantiate()
	new_bullet.player_index = controls.player_index
	%Marker3D.add_child(new_bullet)
	
	new_bullet.global_transform = %Marker3D.global_transform
	
	%Timer.start()
