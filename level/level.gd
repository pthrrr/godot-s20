extends Node3D

var player_score = 0
var mob_counter = 0

const MAX_MOBS = 20

@onready var score_counter_label = %ScoreCounterLabel
@onready var label_mob: Label = %Label_mob
@onready var spawner1 = $MobSpawner1
@onready var spawner2 = $MobSpawner2
@export var max_mobs: int = 20


func get_total_mobs() -> int:
	return spawner1.mob_counter + spawner2.mob_counter


func increase_score(player_index):
	if player_index == 0:
		player_score += 1
		score_counter_label.text = "Score: " + str(player_score)


func _on_mob_spawner_3d_mob_spawned(mob):
	mob_counter += 1
	label_mob.text = "Mob: " + str(mob_counter)
	
	if mob_counter >= MAX_MOBS:
		spawner1.get_node("SpawnTimer").stop()
		spawner2.get_node("SpawnTimer").stop()
	
	mob.kill.connect(increase_score)
	mob.died.connect(func(_player_index):
		do_poof(mob.global_position)
		mob_counter -= 1
		label_mob.text = "Mob: " + str(mob_counter)
		if mob_counter < MAX_MOBS:
			spawner1.get_node("SpawnTimer").start()
			spawner2.get_node("SpawnTimer").start()
	)
	do_poof(mob.global_position)


func do_poof(mob_global_position):
	const SMOKE_PUFF = preload("uid://cjk3frr43yesb")
	var poof = SMOKE_PUFF.instantiate()
	add_child(poof)
	poof.global_position = mob_global_position
