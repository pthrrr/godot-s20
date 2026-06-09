extends Node2D

var spawn_position_player: Vector3
var countdown = 30
var countdown_str = ""

@onready var level: Node3D = $Level1
@onready var timer_label: Label = $TimerLabel
@onready var round_timer = $RoundTimer
@onready var main_screen: Control = $MainScreen

static var first_launch = true


@onready var players := {
	"1": {
		camera = $"Camera3D",
		player = $Level1/Player,
		label = $"Label",
	},
}

func _ready():
	if first_launch:
		get_tree().paused = true
		first_launch = false
	else:
		main_screen.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
	spawn_position_player = players["1"].player.global_position
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
	if body.controls.player_index == 0:
		body.global_position = spawn_position_player
		players["1"].label.text = "Score: " + str(0)
		level.player_score = 0
	body.velocity = Vector3.ZERO


func _on_round_timer_timeout():
	get_tree().paused = true
	main_screen.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$MainScreen/CenterContainer/VBoxContainer/ResumeButton.visible = false
	$MainScreen/CenterContainer/VBoxContainer/StartButton.text = "Restart"
