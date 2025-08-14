extends Node2D

@export var enemy: CharacterBody2D
@export var dialogue: String
@export var chatbox: CollisionShape2D  # this should be the CollisionShape2D under your Area2D


@export var achieve: RichTextLabel
@export var anim: AnimationPlayer
@export var panel: Panel
@export var audio: AudioStreamPlayer2D
@export var name_ach: String
var loaded = false
var player_in_area := false

func _ready() -> void:
	preload_achievement()
	#debug
	print("[PACMAN] first_time_pacman =", global.first_time_pacman)

	if global.first_time_pacman:
		if enemy:
			enemy.visible = false
			enemy.set_physics_process(false)
		if chatbox:
			chatbox.disabled = false
	else:

		if enemy:
			enemy.visible = true
			enemy.set_physics_process(true)
		if chatbox:
			chatbox.disabled = true

func _on_area_2d_body_entered(body: Node2D) -> void:

	if not (body.is_in_group("player") or body.name == "Player"):
		return

	player_in_area = true
	print("[PACMAN] Player entered trigger. first_time_pacman =", global.first_time_pacman)


	if global.first_time_pacman:
		global.first_time_pacman = false      
		if chatbox:
			chatbox.disabled = true         
		_start_dialogue_once()
	else:
		if enemy:
			enemy.visible = true
			enemy.set_physics_process(true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		player_in_area = false

func _start_dialogue_once() -> void:
	if not Dialogic.timeline_ended.is_connected(_on_dialogue_end):
		Dialogic.timeline_ended.connect(_on_dialogue_end, CONNECT_ONE_SHOT)
	print("[PACMAN] Starting dialogue:", dialogue)
	Dialogic.start(dialogue)

func _on_dialogue_end() -> void:
	print("[PACMAN] Dialogue ended -> enabling enemy")
	achiement_sound()
	if enemy:
		enemy.visible = true
		enemy.set_physics_process(true)
		
func achiement_sound():
	loaded = true
	achieve.visible = true
	panel.visible = true
	audio.stream = preload("res://assets/sfx/achievement.wav")
	anim.play("fade_pin")
	audio.play()
	await get_tree().create_timer(2.5).timeout
	anim.play("fade_put")
	
func preload_achievement():
	achieve.visible = false
	panel.visible = false
	achieve.text = name_ach
