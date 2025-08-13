extends CharacterBody2D

@export var speed: float = 80.0
@export var player: Node2D
@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	# Small thresholds so the agent considers the point reached and advances
	agent.path_desired_distance = 4.0
	agent.target_desired_distance = 6.0
	agent.max_speed = speed

func _physics_process(delta: float) -> void:
	if not player:
		return

	# Continuously chase the player's current position
	agent.target_position = player.global_position

	# Where to go next along the path
	var next_point: Vector2 = agent.get_next_path_position()
	var dir := (next_point - global_position)
	if dir.length() > 0.001:
		dir = dir.normalized()
	else:
		dir = Vector2.ZERO

	velocity = dir * speed
	move_and_slide()

	# (Optional) flip sprite based on motion
	if velocity.x != 0.0:
		sprite.flip_h = velocity.x < 0.0
