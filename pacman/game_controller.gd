extends Node2D

@onready var player = get_node("../Player")
@onready var enemy = get_node("../ShadowPatrols/PatrolEnemy1")

const CATCH_DISTANCE = 16.0  # You can adjust this value

func _on_player_caught():
	print("You were caught!")
	# Example: go to game over scene
	# get_tree().change_scene_to_file("res://GameOver.tscn")

	# Or restart the minigame
	# get_tree().reload_current_scene()

	# You can also play a scream sound or flash the screen

signal mini_game_completed(result: bool)

@onready var timer_label = get_node("../UI/TimerLabel")
@onready var sanity_bar = get_node("../UI/SanityBar")
@onready var exit_door = get_node("../ExitDoor")
@onready var tile_map = get_node("../CorridorTilemap")
@onready var ambience_player = get_node("../Audio/AmbiencePlayer")
@onready var heartbeat_player = get_node("../Audio/HeartbeatPlayer")
var time_left = 60.0
var sanity = 100.0
var crashed = false

func _ready():
	# Start ambience if you have
	if ambience_player:
		ambience_player.play()

	var used_rect = tile_map.get_used_rect()
	
	# Get the size of one tile in pixels (Godot 4 way)
	var tile_size = tile_map.tile_set.tile_size
	
	# Calculate tilemap size in pixels
	var tilemap_size = used_rect.size * tile_size
	
	var viewport_center = get_viewport().size / 2
	var offset = viewport_center - (tilemap_size / 2)
	global_position = offset

func _process(delta):
	if crashed:
		return

	# Player catch detection
	if player and enemy:
		var distance = player.global_position.distance_to(enemy.global_position)
		if distance <= CATCH_DISTANCE:
			_on_player_caught()

	# Timer & sanity
	time_left -= delta
	update_ui()
	sanity = max(sanity - delta * 2, 0)

	if time_left <= 0 or sanity <= 0:
		fail_sequence()

	# Heartbeat sound if low sanity
	if sanity < 50 and heartbeat_player:
		if not heartbeat_player.playing:
			heartbeat_player.play()

func update_ui():
	timer_label.text = "Time: %d" % int(time_left)
	sanity_bar.value = sanity

func fail_sequence():
	emit_signal("mini_game_completed", false)
	# You can show a “You died” message or restart
	print("FAILED: caught or time/sanity up")
	# disable player
	player.set_process(false)

func succeed():
	emit_signal("mini_game_completed", true)
	print("SUCCESS: exit reached")
	player.set_process(false)

func _on_exit_door_body_entered(body):
	if body == player:
		succeed()

var alt_pressed = false
var f4_pressed = false

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_ALT:
				alt_pressed = true
			if event.keycode == KEY_F4:
				f4_pressed = true
			if alt_pressed and f4_pressed:
				_trigger_fake_crash()
		else:
			# Reset when keys are released
			if event.keycode == KEY_ALT:
				alt_pressed = false
			if event.keycode == KEY_F4:
				f4_pressed = false

func _trigger_fake_crash():
	get_tree().change_scene_to_file("res://CrashScreen.tscn")
	await get_tree().create_timer(2.0).timeout  # Show for 2 seconds
	get_tree().change_scene_to_file("res://HardLevel.tscn")  # Go to harder level
