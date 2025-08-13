extends Node2D

@export var enemy: CharacterBody2D
@export var dialogue: String
@export var chatbox: CollisionShape2D

var player_in_area = false
var dialogue_started = false  # ✅ New flag

func _ready() -> void:
	enemy.set_physics_process(false)
	enemy.visible = false

func _process(delta: float) -> void:
	if player_in_area and not dialogue_started:
		dialogue_started = true  # ✅ Prevents replay
		chatbox.disabled = true
		Dialogic.start(dialogue)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # ✅ More reliable check
		player_in_area = true
