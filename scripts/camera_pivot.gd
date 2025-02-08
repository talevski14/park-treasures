extends Marker3D

@export var sensitivity: float = 0.005

func _input(event):  		
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("move_scene"):
			var mouse_velocity = Input.get_last_mouse_velocity()
			rotate_y(deg_to_rad(-mouse_velocity.x * sensitivity))
