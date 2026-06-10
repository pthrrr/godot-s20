extends Node2D

var spawn_position_player: Vector3
var countdown = 30
var countdown_str = ""

@onready var level: Node3D = $GameLevel
@onready var round_timer_label: Label = $RoundTimerLabel
@onready var round_timer = $RoundTimer
@onready var main_menu: Control = $MainMenu

static var first_launch = true


@onready var players := {
	"1": {
		camera = $"PlayerCam",
		player = $GameLevel/Player,
		score_counter_label = $"ScoreCounterLabel",
	},
}

func _ready():
	if first_launch:
		get_tree().paused = true
		first_launch = false
	else:
		main_menu.visible = false
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
	round_timer_label.text = "00:" + countdown_str
	
	
func _on_kill_plane_body_entered(body):
	if not body is CharacterBody3D:
		return
	if body.controls.player_index == 0:
		body.global_position = spawn_position_player
		players["1"].score_counter_label.text = "Score: " + str(0)
		level.player_score = 0
	body.velocity = Vector3.ZERO


func _on_round_timer_timeout():
	get_tree().paused = true
	main_menu.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$MainMenu/CenterContainer/VBoxContainer/ResumeButton.visible = false
	$MainMenu/CenterContainer/VBoxContainer/StartButton.text = "Restart"
