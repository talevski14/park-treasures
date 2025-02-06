extends CharacterBody3D

@export var speed = 14
@export var fall_acceleration = 75
@onready var anim_player = $Pivot/StylizedCharacter/AnimationPlayer

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
		anim_player.play("Armature|Run")
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		anim_player.play("Armature|Run")
	if Input.is_action_pressed("move_back"):
		direction.z += 1
		anim_player.play("Armature|Run")
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		anim_player.play("Armature|Run")
	
	if Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left") or Input.is_action_just_released("move_forward") or Input.is_action_just_released("move_back"):
		anim_player.play("Armature|Iddle")

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction)

	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	velocity = target_velocity
	move_and_slide()
