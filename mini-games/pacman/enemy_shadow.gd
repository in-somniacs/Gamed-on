extends CharacterBody2D

@export var speed: float = 80.0
@export var player: Node2D
@export var attack_range: float = 20.0  # Distance before enemy attacks
@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var jumpscare_audio: AudioStreamPlayer
@export var jumpscare: Panel
@export var ani:AnimationPlayer

var last_dir: Vector2 = Vector2.DOWN
var attacking: bool = false

func _ready() -> void:
	jumpscare_audio.stream = preload("res://assets/sfx/jumpscare_audio.mp3")
	jumpscare.visible = false
	global.enable_player_movement()
	agent.path_desired_distance = 4.0
	agent.target_desired_distance = 10.0
	agent.max_speed = speed

func _physics_process(delta: float) -> void:
	if not player:
		return

	# If attacking, don't move or animate walking
	if attacking:
		return

	var distance_to_player = global_position.distance_to(player.global_position)

	# Check if close enough to attack
	if distance_to_player <= attack_range:
		start_attack()
	if attacking == true:
		global.disable_player_movement()
		sprite.pause()
		jumpscare.visible = true
		jumpscare_audio.play()
		await get_tree().create_timer(2).timeout
		ani.play("fade_out")
		await get_tree().create_timer(1).timeout
		get_tree().reload_current_scene()
		


	# Pathfinding movement
	agent.target_position = player.global_position
	var next_point: Vector2 = agent.get_next_path_position()
	var dir := (next_point - global_position)

	if dir.length() > 0.001:
		dir = dir.normalized()
	else:
		dir = Vector2.ZERO

	velocity = dir * speed
	move_and_slide()

	# Animation for walking
	if velocity != Vector2.ZERO:
		last_dir = velocity
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				sprite.play("walking_right")
			else:
				sprite.play("walking_left")
		else:
			if velocity.y > 0:
				sprite.play("walking_down")
			else:
				sprite.play("walking_up")
	else:
		sprite.play("idle")


func start_attack():
	attacking = true
	velocity = Vector2.ZERO
	move_and_slide()

	# Choose attack animation based on last movement direction
	if abs(last_dir.x) > abs(last_dir.y):
		if last_dir.x > 0:
			sprite.play("attack_right")
		else:
			sprite.play("attack_left")
	else:
		if last_dir.y > 0:
			sprite.play("attack_down")
		else:
			sprite.play("attack_up")

	# Wait for attack animation to finish
	await sprite.animation_finished
	attacking = false
