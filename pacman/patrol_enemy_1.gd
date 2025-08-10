extends CharacterBody2D

@export var waypoints: Array[Vector2] = []
const SPEED = 100
const REACH_THRESHOLD = 5.0

func _physics_process(_delta):
	if waypoints.is_empty():
		return
	var target = waypoints[current_index()]
	var dir = target - global_position
	if dir.length() < REACH_THRESHOLD:
		_advance_index()
	else:
		velocity = dir.normalized() * SPEED  # built-in velocity
		move_and_slide()

func current_index() -> int:
	# stored in metadata so we don't shadow anything
	if not self.has_meta("idx"):
		self.set_meta("idx", 0)
	return self.get_meta("idx")

func _advance_index():
	var idx = current_index()
	idx = (idx + 1) % waypoints.size()
	self.set_meta("idx", idx)

func _on_body_entered(body):
	if body.name == "Player":
		get_tree().call_group("GameController", "on_player_caught")
