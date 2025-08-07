extends CharacterBody2D

var SPEED = 4000.0
@onready var anim = $AnimatedSprite2D
var can_move : bool = true

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector('left', 'right', 'up', 'down')
	
	if !can_move:
		anim.play("side_idle")
		return
	
	if direction.length():
		velocity.x = direction.x * delta * SPEED
		velocity.y = direction.y * delta * SPEED
		#look_at(position + direction)
		
		if direction.y == 0 && direction.x == 0:
			anim.play("front_idle")
		elif abs(direction.x) > abs(direction.y):
			anim.flip_h = direction.x < 0
			anim.play("side_walk")
		elif direction.y < 0:
			anim.play("back_walk")
		elif direction.y > 0:
			anim.play("front_walk")
			
	else:
		
		if anim.animation == "side_walk":
			anim.play("side_idle")
		elif anim.animation == "front_walk":
			anim.play("side_idle")
		elif anim.animation == "back_walk":
			anim.play("side_idle")
			
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("run"):
		SPEED = SPEED + 4000
	elif Input.is_action_just_released("run"):
		SPEED = SPEED - 4000
	


	
