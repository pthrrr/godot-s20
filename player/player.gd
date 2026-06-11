extends CharacterBody3D

@export var controls: Resource = null

var knockback_velocity = Vector3.ZERO

func _ready():
	pass


func _unhandled_input(event):
	if event is InputEventMouseMotion and controls.player_index == 0:
		rotation_degrees.y -= event.relative.x * 0.2
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.2
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x, -80.0, 80.0
		)
	elif event.is_action_pressed("ui_cancel"):
		$MenuSound.play()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		var main_screen = get_tree().current_scene.get_node("MainScreen")
		main_screen.visible = true
		main_screen.get_node("CenterContainer/VBoxContainer/ResumeButton").visible = true
		main_screen.get_node("CenterContainer/VBoxContainer/ResumeButton").grab_focus()
		main_screen.get_node("CenterContainer/VBoxContainer/StartButton").text = "Restart"
		var game = get_tree().current_scene
		game.music_position = game.get_node("MainMusic").get_playback_position()
		game.get_node("MainMusic").stop()
		game.get_node("MenuMusic").play()
		
func _physics_process(delta):
	const SPEED = 5.5
	
	var input_direction_2D = Input.get_vector(
		controls.move_left, controls.move_right, controls.move_forward, controls.move_backward
	)
	var input_direction_3D = Vector3(
		input_direction_2D.x, 0.0, input_direction_2D.y
	)
	var direction = transform.basis * input_direction_3D
	
	velocity.x = direction.x * SPEED + knockback_velocity.x
	velocity.z = direction.z * SPEED + knockback_velocity.z
	
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

	if is_on_floor():
		var floor_normal = get_floor_normal()
		var slope_angle = floor_normal.angle_to(Vector3.UP)
		if slope_angle > deg_to_rad(10):
			var slide_dir = Vector3(floor_normal.x, 0, floor_normal.z).normalized()
			velocity += slide_dir * slope_angle * 5.0

	move_and_slide()
	
	if Input.is_action_pressed(controls.shoot) and %Timer.is_stopped():
		shoot_bullet()

	
func shoot_bullet():
	const BULLET_3D = preload("uid://ceb27mcygqh27")
	var new_bullet = BULLET_3D.instantiate()
	new_bullet.player_index = controls.player_index
	%Marker3D.add_child(new_bullet)
	
	new_bullet.global_transform = %Marker3D.global_transform
	
	%Timer.start()
	%GunShot.play()
