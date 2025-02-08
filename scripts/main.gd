extends Node

@export var treasure_scene: PackedScene

func _on_treasure_collected() -> void:
	var treasure = treasure_scene.instantiate()
	
	var treasure_spawn_location = get_node("SpawnPath/SpawnLocation")
	treasure_spawn_location.progress_ratio = randf()
	
	add_child(treasure)
