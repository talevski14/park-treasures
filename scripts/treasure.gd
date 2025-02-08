extends CharacterBody3D

signal collected

func collect():
	collected.emit()
	queue_free()
	
