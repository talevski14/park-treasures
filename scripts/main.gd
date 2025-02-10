extends Node

@export var treasure_scene_1: PackedScene
@export var treasure_scene_2: PackedScene
@export var treasure_scene_3: PackedScene
@export var treasure_scene_4: PackedScene
@export var treasure_scene_5: PackedScene

@onready var timer = $Timer
@onready var timer_label = $UserInterface/TimerLabel
var time_left = 30

var treasure_array = []

func _ready() -> void:
	randomize()
	treasure_array = [treasure_scene_1, treasure_scene_2, treasure_scene_3, treasure_scene_4, treasure_scene_5]
	
	timer.wait_time = 1.0
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	update_ui()

func _on_treasure_collected() -> void:
	var treasure_scene = treasure_array[randi() % treasure_array.size()]
	var treasure = treasure_scene.instantiate()
	var treasure_spawn_location = get_node("SpawnPath/SpawnLocation")
	
	treasure_spawn_location.progress_ratio = randf()
	add_child(treasure)
	treasure.global_transform.origin = treasure_spawn_location.global_transform.origin
	
	treasure.collected.connect($UserInterface/ScoreLabel._on_treasure_collected.bind())
	treasure.collected.connect(_on_treasure_collected.bind())

func _on_timer_timeout():
	if time_left > 0:
		time_left -= 1
		update_ui()
	
		if time_left == 0:
			game_over()

func update_ui():
	timer_label.text = str(time_left) + "s"

func game_over():
	timer.stop()
	print("Game Over!")
