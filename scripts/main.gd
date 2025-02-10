extends Node

@export var treasure_scene_1: PackedScene
@export var treasure_scene_2: PackedScene
@export var treasure_scene_3: PackedScene
@export var treasure_scene_4: PackedScene
@export var treasure_scene_5: PackedScene

@onready var timer = $Timer
@onready var timer_label = $UserInterface/TimerLabel

var current_score = 0
var score_to_win = 10
var time_left = 100

var treasure_array = []

func _ready() -> void:
	$UserInterface/Win.hide()
	$UserInterface/Lose.hide()
	
	randomize()
	treasure_array = [treasure_scene_1, treasure_scene_2, treasure_scene_3, treasure_scene_4, treasure_scene_5]
	
	timer.wait_time = 1.0
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	update_ui()

func _on_treasure_collected() -> void:
	current_score += 1
	if current_score >= score_to_win:
		winner()
		
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

func format_time(seconds: int) -> String:
	var minutes = seconds / 60
	var secs = seconds % 60
	return "%d:%02d" % [minutes, secs] 

func update_ui():
	timer_label.text = str(format_time(time_left))

func game_over():
	timer.stop()
	$Player.set_physics_process(false)
	$UserInterface/Lose.show()

func winner():
	timer.stop()
	$Player.set_physics_process(false)
	$UserInterface/Win.show()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and ($UserInterface/Win.visible or $UserInterface/Lose.visible):
		get_tree().reload_current_scene()
