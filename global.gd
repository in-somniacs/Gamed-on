extends Node
var canmove = true
var current_scene = "world"
var transition_scene = false
var has_played_room_intro = false
var input_disabled = false
var player_exit_roomx = 432
var player_exit_roomy = -503
var player_startx = 48
var player_starty = 52
var console_set = false
var has_played_room_intro_achievement = false
var set_console = false
var new_scene_placement: String
var game_first_loadin = true
var is_switching = false
var crt_enabled = false
var arcade_door = true
var first_time_arcade = false
var minigame = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func finish_change_scene():
	transition_scene = false
	if current_scene == "world":
		current_scene = "cliff-side"
	elif current_scene == "cliff-side":
		current_scene = "world"


func enable_player_movement():
	canmove = true

func disable_player_movement():
	canmove = false
	print("dadsada")
