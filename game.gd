extends Node2D

var spawn_position_player: Vector3
var spawn_position_player2: Vector3
var countdown = 30
var countdown_str = ""

@onready var level = $HBoxContainer/SubViewportContainer/SubViewport/Level1
@onready var timer_label = $TimerLabel
@onready var round_timer = $RoundTimer
@onready var main_screen: Control = $MainScreen
@onready var gameover_screen: Control = $GameOverScreen

static var first_launch = true
@onready var green = $HBoxContainer/SubViewportContainer/SubViewport/Green
@onready var green2 = $HBoxContainer/SubViewportContainer2/SubViewport/Green2
@onready var label_win = $HBoxContainer/SubViewportContainer/SubViewport/Label_win
@onready var label_win_2 = $HBoxContainer/SubViewportContainer2/SubViewport/Label_win2

@onready var players := {
	"1": {
		viewport = $"HBoxContainer/SubViewportContainer/SubViewport",
		camera = $"HBoxContainer/SubViewportContainer/SubViewport/Camera3D",
		player = $HBoxContainer/SubViewportContainer/SubViewport/Level1/Player,
		label = $"HBoxContainer/SubViewportContainer/SubViewport/Label",
	},
	"2": {
		viewport = $"HBoxContainer/SubViewportContainer2/SubViewport",
		camera = $"HBoxContainer/SubViewportContainer2/SubViewport/Camera3D",
		player = $HBoxContainer/SubViewportContainer/SubViewport/Level1/Player2,
		label = $"HBoxContainer/SubViewportContainer2/SubViewport/Label2",
	}
}

func _ready():
	if first_launch:
		get_tree().paused = true
		first_launch = false
		%MainMusic.stop()
		%MenuMusic.play()
	else:
		main_screen.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		%MenuMusic.stop()
		%MainMusic.play()
	
	spawn_position_player = players["1"].player.global_position
	spawn_position_player2 = players["2"].player.global_position
	players["2"].viewport.world_3d = players["1"].viewport.world_3d
	for node in players.values():
		var remote_transform := RemoteTransform3D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.get_node("Camera3D").add_child(remote_transform)


func _physics_process(delta):
	countdown = int(round_timer.time_left)
	countdown_str = str(countdown)
	if countdown < 10:
		countdown_str = "0" + str(countdown)
	timer_label.text = "00:" + countdown_str
	
	
func _on_kill_plane_body_entered(body):
	if not body is CharacterBody3D:
		return
	get_tree().paused = true
	gameover_screen.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	%MainMusic.stop()
	%MenuMusic.play()


func _on_round_timer_timeout():
	get_tree().paused = true
	main_screen.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$MainScreen/CenterContainer/VBoxContainer/ResumeButton.visible = false
	$MainScreen/CenterContainer/VBoxContainer/StartButton.text = "Restart"
	%MainMusic.stop()
	%MenuMusic.play()
	
	if int(players["1"].label.text.lstrip("Score:")) == int(players["2"].label.text.lstrip("Score:")):
		print("Draw")
	elif int(players["1"].label.text.lstrip("Score:")) > int(players["2"].label.text.lstrip("Score:")):
		green.visible = true
		label_win.visible = true
	elif int(players["1"].label.text.lstrip("Score:")) > int(players["2"].label.text.lstrip("Score:")):
		green2.visible = true
		label_win_2.visible = true
	
