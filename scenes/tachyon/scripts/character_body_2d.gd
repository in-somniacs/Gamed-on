extends CharacterBody2D


var SPEED = 4000.0


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector('left', 'right', 'up', 'down')

	if direction.length():
		velocity.x = direction.x * delta * SPEED
		velocity.y = direction.y * delta * SPEED
		#look_at(position + direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("run"):
		SPEED = SPEED + 8000
	elif Input.is_action_just_released("run"):
		SPEED = SPEED - 8000
