extends Node

var current_scene = "world"
var transition_scene = false

var player_exit_roomx = 0
var player_exit_roomy = 0
var player_startx = 0
var player_starty = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func finish_change_scene():
	if transition_scene == true:
		transition_scene == false
		if current_scene == "world":
			current_scene = "cliff-side"
		else:
			current_scene = "world"
		
