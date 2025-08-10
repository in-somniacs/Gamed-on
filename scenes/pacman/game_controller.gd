extends Node

@onready var player = get_node("../Player")
@onready var enemy = get_node("../Enemy")

const CATCH_DISTANCE = 16.0  # You can adjust this value

func _process1(delta):
	if player and enemy:
		var distance = player.global_position.distance_to(enemy.global_position)
		if distance <= CATCH_DISTANCE:
			_on_player_caught()

func _on_player_caught():
	print("You were caught!")
	# Example: go to game over scene
	# get_tree().change_scene_to_file("res://GameOver.tscn")

	# Or restart the minigame
	# get_tree().reload_current_scene()

	# You can also play a scream sound or flash the screen

signal mini_game_completed(result: bool)

@onready var crash_screen = $CrashScreen
@onready var timer_label = $UI/TimerLabel
@onready var sanity_bar = $UI/SanityBar
@onready var exit_door = $ExitDoor
var time_left = 60.0
var sanity = 100.0
var crashed = false

func _ready():
	crash_screen.visible = false
	# Start ambience if you have
	if $Audio/AmbiencePlayer:
		$Audio/AmbiencePlayer.play()

func _process(delta):
	if crashed:
		return
	time_left -= delta
	update_ui()
	# simple sanity drain over time
	sanity = max(sanity - delta * 2, 0)
	if time_left <= 0 or sanity <= 0:
		fail_sequence()
	if sanity < 50 and $Audio/HeartbeatPlayer:
		if not $Audio/HeartbeatPlayer.playing:
			$Audio/HeartbeatPlayer.play()


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

func on_player_caught():
	fail_sequence()

func _input(event):
	if event.is_action_pressed("alt_f4") and not crashed:
		get_tree().set_input_as_handled()
		trigger_fake_crash()

func trigger_fake_crash():
	crashed = true
	# Pause normal ambience
	if $Audio/AmbiencePlayer:
		$Audio/AmbiencePlayer.stop()
	# Show crash overlay
	crash_screen.visible = true
	# Optional: play glitch
	if $Audio/GlitchPlayer:
		$Audio/GlitchPlayer.play()
	player.set_process(false)
	# Wait then “reboot”
	await get_tree().create_timer(3.0).timeout
	perform_reboot()

func perform_reboot():
	crash_screen.visible = false
	apply_corrupted_state()
	# Resume, penalize sanity
	sanity = max(sanity - 20, 0)
	player.set_process(true)
	# Optionally change ambience (e.g., start a more unsettling loop)
	crashed = false

func apply_corrupted_state():
	# Example secret: shift exit so a second hidden exit appears
	# (You can also change tile colors, add an overlay, etc.)
	exit_door.global_position += Vector2(64, 0)  # reveal alternate door position
	# Optionally tint world with color overlay, spawn ghost sprite, etc.
