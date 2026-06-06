extends RigidBody3D

var speed = randf_range(2.0, 4.0)

@onready var bat_model = %bat_model

@onready var player = get_node("/root/Game/HBoxContainer/SubViewportContainer/SubViewport/Level1/Player")

@onready var player2 = get_node("/root/Game/HBoxContainer/SubViewportContainer/SubViewport/Level1/Player2")


func _physics_process(delta):
	var direction_player = global_position.direction_to(player.global_position)
	var direction_player2 = global_position.direction_to(player2.global_position)
	direction_player.y = 0.0
	direction_player2.y = 0.0
	
	var dist_p1 = global_position.distance_to(player.global_position)
	var dist_p2 = global_position.distance_to(player2.global_position)
	if dist_p1 < dist_p2:
		linear_velocity = direction_player * speed
		bat_model.global_rotation.y = Vector3.FORWARD.signed_angle_to(direction_player, Vector3.UP) + PI
	else:
		linear_velocity = direction_player2 * speed
		bat_model.global_rotation.y = Vector3.FORWARD.signed_angle_to(direction_player2, Vector3.UP) + PI


func take_damage():
	bat_model.hurt()
