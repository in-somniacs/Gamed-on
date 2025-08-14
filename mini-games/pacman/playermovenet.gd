extends CharacterBody2D

@export var SPEED = 4000.0
@export var MAX_STAMINA: float = 100.0
@export var STAMINA_DRAIN: float = 20.0   # per second while sprinting
@export var STAMINA_RECOVERY: float = 10.0 # per second when not sprinting
@export var sprint_multiplier: float = 2.0

@onready var anim = $AnimatedSprite2D
@export var stamina_bar: ProgressBar

@export var Inventory: In
var can_move : bool = true
@export var ani: AnimationPlayer

var stamina: float
var is_sprinting: bool = false

func _ready() -> void:
	add_to_group("player")
	global.arcade_game = false
	global.coin_total = 0
	stamina = MAX_STAMINA
	stamina_bar.max_value = MAX_STAMINA
	stamina_bar.value = stamina

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector('left', 'right', 'up', 'down')

	# Sprint logic
	if Input.is_action_pressed("run") and stamina > 0:
		is_sprinting = true
	else:
		is_sprinting = false

	if !can_move:
		anim.play("side_idle")
		return

	if direction.length() && global.canmove == true:
		if is_sprinting:
			velocity.x = direction.x * delta * SPEED * sprint_multiplier
			velocity.y = direction.y * delta * SPEED * sprint_multiplier
			stamina = max(stamina - STAMINA_DRAIN * delta, 0)
		else:
			velocity.x = direction.x * delta * SPEED
			velocity.y = direction.y * delta * SPEED
			stamina = min(stamina + STAMINA_RECOVERY * delta, MAX_STAMINA)

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
		stamina = min(stamina + STAMINA_RECOVERY * delta, MAX_STAMINA)

	# Update stamina bar
	stamina_bar.value = stamina

	move_and_slide()

func player():
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_method("collect"):
		area.collect(Inventory)
