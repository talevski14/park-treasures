extends Camera3D

func _input(event):  		
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("move_scene"):
			rotate_object_local(Vector3.UP, event.relative.x * 0.001)
