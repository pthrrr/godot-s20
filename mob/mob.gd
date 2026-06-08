extends RigidBody3D

signal died(player)
signal kill(killer_player_index)

var health = 3
var speed = randf_range(2.0, 4.0)
var killer_player_index = 0

@onready var bat_model = %bat_model
@onready var timer = %Timer

@onready var hurt_sound = %HurtSound
@onready var die_sound = %DieSound

@onready var player = get_node("/root/Game/HBoxContainer/SubViewportContainer/SubViewport/Level1/Player")

@onready var player2 = get_node("/root/Game/HBoxContainer/SubViewportContainer/SubViewport/Level1/Player2")

@onready var raycast = $RayCast3D


func _physics_process(delta):
	var direction_player = global_position.direction_to(player.global_position)
	var direction_player2 = global_position.direction_to(player2.global_position)
	direction_player.y = 0.0
	direction_player2.y = 0.0
	
	var dist_p1 = global_position.distance_to(player.global_position)
	var dist_p2 = global_position.distance_to(player2.global_position)
	if dist_p1 < dist_p2:
		raycast.target_position = direction_player * 8.0
		linear_velocity = direction_player * speed
		bat_model.global_rotation.y = Vector3.FORWARD.signed_angle_to(direction_player, Vector3.UP) + PI
	else:
		raycast.target_position = direction_player2 * 8.0
		linear_velocity = direction_player2 * speed
		bat_model.global_rotation.y = Vector3.FORWARD.signed_angle_to(direction_player2, Vector3.UP) + PI

	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider is CharacterBody3D:
			pass


func take_damage(player_index):
	if health == 0:
		return
	bat_model.hurt()
	health -= 1
	hurt_sound.play()
	
	if health == 0:
		killer_player_index = player_index
		set_physics_process(false)
		gravity_scale = 1.0
		
		var dist_p1 = global_position.distance_to(player.global_position)
		var dist_p2 = global_position.distance_to(player2.global_position)
		var random_upward_force = Vector3.UP * randf_range(1.0, 5.0)
		
		if dist_p1 < dist_p2:
			var direction_player = -1.0 * global_position.direction_to(player.global_position)
			apply_central_impulse(direction_player.rotated(Vector3.UP, randf_range(-0.2, 0.2)) * 10.0 + random_upward_force)
		else:
			var direction_player2 = -1.0 * global_position.direction_to(player2.global_position)
			apply_central_impulse(direction_player2.rotated(Vector3.UP, randf_range(-0.2, 0.2)) * 10.0 + random_upward_force)

		timer.start()
		die_sound.play()
		kill.emit(killer_player_index)


func _on_timer_timeout():
	died.emit(killer_player_index)
	queue_free()
