extends Node2D

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
