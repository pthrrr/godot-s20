extends Camera3D

var target_camera: Camera3D


func _process(_delta):
	if target_camera:
		global_transform = target_camera.global_transform
