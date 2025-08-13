extends Node2D

@export var dialogue: String  # Dialogic resource name

func _ready():
	# Run only the first time player enters this minigame
	if not global.first_time_mario:
		global.first_time_mario = true
		do_first_time_intro()

func do_first_time_intro():

	global.disable_player_movement()


	Dialogic.start(dialogue)
	global.enable_player_movement()
	


	
