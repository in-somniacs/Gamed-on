extends Node
var canmove = true
var current_scene = "world"
var transition_scene = false
var has_played_room_intro = false

var player_exit_roomx = 432
var player_exit_roomy = -503
var player_startx = 48
var player_starty = 52

var game_first_loadin = true

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
