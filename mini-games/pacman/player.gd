extends CharacterBody2D

const SPEED = 180
const ACCEL = 10

func _physics_process(delta):
	var target = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	if target != Vector2.ZERO:
		target = target.normalized() * SPEED
	# Interpolate toward target for smoother movement
	velocity = velocity.lerp(target, ACCEL * delta)
	move_and_slide()
