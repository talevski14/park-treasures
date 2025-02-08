extends CharacterBody3D

@export var speed = 14
@export var fall_acceleration = 75
@export var pivot: Node3D
@onready var anim_player = $Pivot/StylizedCharacter/AnimationPlayer

var target_velocity = Vector3.ZERO
@export var jump_impulse = 30

var score = 0

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction -= pivot.transform.basis.x
		anim_player.play("Armature|Run")
	if Input.is_action_pressed("move_left"):
		direction += pivot.transform.basis.x
		anim_player.play("Armature|Run")
	if Input.is_action_pressed("move_back"):
		direction += pivot.transform.basis.z
		anim_player.play("Armature|Run")
	if Input.is_action_pressed("move_forward"):
		direction -= pivot.transform.basis.z
		anim_player.play("Armature|Run")
	
	direction.y = 0
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction)
	
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	velocity = target_velocity
	
	if is_on_floor() and Input.is_action_pressed("jump"):
		target_velocity.y = jump_impulse
		anim_player.play("Armature|Jump")
		
	#if (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_forward") or Input.is_action_pressed("move_back")) and Input.is_action_pressed("jump"):
		#anim_player.play("Armature|Jump")
	
	if Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left") or Input.is_action_just_released("move_forward") or Input.is_action_just_released("move_back"):
		anim_player.play("Armature|Iddle")
	
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)

		if collision.get_collider() == null:
			continue

		if collision.get_collider().is_in_group("gems"):
			var gem = collision.get_collider()
			gem.collect()
			break
			
	move_and_slide()


func _on_treasure_collected() -> void:
	score += 1
	print(score)
