extends Node3D

signal mob_spawned(mob)

var mob_counter = 0
var angle = 0.0
var radius = 20
var speed = 0.3
var center = Vector3.ZERO


@export var mob_to_spawn: PackedScene = null

@onready var spawn_marker = %SpawnMarker


func _ready():
	angle = atan2(global_position.z, global_position.x)

func _physics_process(delta):
	angle += speed * delta
	global_position.x = center.x + cos(angle) * radius
	global_position.z = center.z + sin(angle) * radius
	

func _on_timer_timeout():
	var new_mob = mob_to_spawn.instantiate()
	get_parent().add_child(new_mob)
	new_mob.global_position = spawn_marker.global_position
	mob_spawned.emit(new_mob)
