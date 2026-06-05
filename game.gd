extends Node2D

#@onready var viewport_1: SubViewport = $HBoxContainer/SubViewportContainer/SubViewport
#@onready var viewport_2: SubViewport = $HBoxContainer/SubViewportContainer2/SubViewport
#@onready var follow_camera: Camera3D = $HBoxContainer/SubViewportContainer2/SubViewport/Camera3D
#
#
#func _ready():
	## Share the 3D world between both viewports
	#viewport_2.world_3d = viewport_1.world_3d
#
	## Get player references from the level
	#var level = viewport_1.get_node("Level1")
	#var player_1 = level.get_node("Player")
	#var player_2 = level.get_node("Player2")
#
	## Set Player1's camera as current in viewport 1
	#player_1.get_node("Camera3D").current = true
	## Disable Player2's camera in viewport 1
	#player_2.get_node("Camera3D").current = false
#
	## Set up the follow camera to track Player2's camera
	#follow_camera.current = true
	#follow_camera.target_camera = player_2.get_node("Camera3D")

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
	players["2"].viewport.world_3d = players["1"].viewport.world_3d
	for node in players.values():
		var remote_transform := RemoteTransform3D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.get_node("Camera3D").add_child(remote_transform)
