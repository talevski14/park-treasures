extends Node

@export var treasure_scene: PackedScene

func _on_treasure_collected() -> void:
	var treasure = treasure_scene.instantiate()
	var treasure_spawn_location = get_node("SpawnPath/SpawnLocation")
	
	treasure_spawn_location.progress_ratio = randf()
	add_child(treasure)
	treasure.global_transform.origin = treasure_spawn_location.global_transform.origin
	
	treasure.collected.connect($UserInterface/ScoreLabel._on_treasure_collected.bind())
	treasure.collected.connect(_on_treasure_collected.bind())
