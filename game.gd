extends Node2D

var spawn_position_player: Vector3
var spawn_position_player2: Vector3

@onready var players := {
	"1": {
		viewport = $"HBoxContainer/SubViewportContainer/SubViewport",
		camera = $"HBoxContainer/SubViewportContainer/SubViewport/Camera3D",
		player = $HBoxContainer/SubViewportContainer/SubViewport/Level1/Player,
	},
	"2": {
		viewport = $"HBoxContainer/SubViewportContainer2/SubViewport",
		camera = $"HBoxContainer/SubViewportContainer2/SubViewport/Camera3D",
		player = $HBoxContainer/SubViewportContainer/SubViewport/Level1/Player2,
	}
}

func _ready():
	spawn_position_player = players["1"].player.global_position
	spawn_position_player2 = players["2"].player.global_position
	players["2"].viewport.world_3d = players["1"].viewport.world_3d
	for node in players.values():
		var remote_transform := RemoteTransform3D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.get_node("Camera3D").add_child(remote_transform)


func _on_kill_plane_body_entered(body):
	if not body is CharacterBody3D:
		return
	# get_tree().reload_current_scene.call_deferred()
	if body.controls.player_index == 0:
		body.global_position = spawn_position_player
	elif body.controls.player_index == 1:
		body.global_position = spawn_position_player2
	body.velocity = Vector3.ZERO
