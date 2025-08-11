extends Node2D
@export var dialogue: String 
@export var shader_mesh: MeshInstance2D
@export var glitch_sfx: AudioStreamPlayer2D

func _enter_tree() -> void:

	if global.game_first_loadin:
		$Player.position = Vector2(global.player_startx, global.player_starty)
	else:
		$Player.position = Vector2(global.player_exit_roomx, global.player_exit_roomy)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.is_switching = false
	if global.game_first_loadin == true:
		$Player.position.x = global.player_startx
		$Player.position.y = global.player_starty
	else:
		$Player.position.x = global.player_exit_roomx
		$Player.position.y = global.player_exit_roomy
		
	run_dialogue(dialogue)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scene()


func _on_room_enter_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = true


func _on_room_enter_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/keyroom.tscn")
			global.game_first_loadin = false
			global.finish_change_scene()
		

func run_dialogue(dialogue_string):
	# Enable glitch
	
	shader_mesh.material.set_shader_parameter("glitch_enabled", true)
	
	# Play glitch sound alongside dialogue
	glitch_sfx.stop()
	glitch_sfx.play()

	# Start dialogue immediately
	Dialogic.start(dialogue_string)
	
	# When sound finishes, stop glitch effect
	await get_tree().create_timer(30.0).timeout
	shader_mesh.material.set_shader_parameter("glitch_enabled", false)
