extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -250.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var animated_sprite: AnimatedSprite2D
@onready var audioplayer: AudioStreamPlayer2D = $AudioStreamPlayer2D

var has_jumped = false  # Prevents jump sound from retriggering mid-air

func _ready() -> void:
	global.minigame = false
	add_to_group("player")
func _process(delta: float) -> void:
	pass
		
func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump")
		audioplayer.stream = preload("res://scenes/minigame/minigane1/jump.mp3")
		audioplayer.play()
		has_jumped = true

	# Reset when landed
	if is_on_floor():
		has_jumped = false

	# Movement
	var direction := Input.get_axis("left", "right")

	# Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Choose animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")

	# Apply horizontal movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
func player():
	pass
