extends Node2D
@export var dialogue: String 
@export var shader_mesh: MeshInstance2D
@export var glitch_sfx: AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.first_time_arcade = false

	if not global.first_time_arcade:
		global.first_time_arcade = true
		#await get_tree().create_timer(2.0).timeline  
		run_dialogue(dialogue)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func run_dialogue(dialogue_string):
	# Enable glitch
	global.disable_player_movement()
	shader_mesh.material.set_shader_parameter("glitch_enabled", true)
	
	# Play glitch sound alongside dialogue
	glitch_sfx.stop()
	glitch_sfx.play()
	await get_tree().create_timer(2).timeout
	# Start dialogue immediately
	Dialogic.start(dialogue_string)
	global.enable_player_movement()
	# When sound finishes, stop glitch effect
	await get_tree().create_timer(20.0).timeout
	shader_mesh.material.set_shader_parameter("glitch_enabled", false)
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
