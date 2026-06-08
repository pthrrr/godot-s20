extends Node3D

signal mob_spawned(mob)

var mob_counter = 0

@export var mob_to_spawn: PackedScene = null

@onready var marker_3d = %Marker3D
@onready var timer = %Timer


func _on_timer_timeout():
	var new_mob = mob_to_spawn.instantiate()
	get_parent().add_child(new_mob)
	new_mob.global_position = marker_3d.global_position
	mob_spawned.emit(new_mob)
