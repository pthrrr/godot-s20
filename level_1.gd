extends Node3D

var player_score = 0
var player2_score = 0

@onready var label = %Label
@onready var label_2 = %Label2


func increase_score(player_index):
	if player_index == 0:
		player_score += 1
		label.text = "Score: " + str(player_score)
	elif player_index == 1:
		player2_score += 1
		label_2.text = "Score: " + str(player2_score)


func _on_mob_spawner_3d_mob_spawned(mob):
	mob.died.connect(increase_score)
