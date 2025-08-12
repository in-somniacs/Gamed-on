extends Area2D
@export var hint: RichTextLabel 
@export var player: CharacterBody2D 
@export var next_scene: String 
@export var popup: NinePatchRect
@export var box: CollisionShape2D
@export var dialogue: String
@export var shader_mesh : MeshInstance2D 
@export var glitch_sfx : AudioStreamPlayer2D 
var player_in_area = false

var interactable = false

func _ready():
	global.new_scene_placement = next_scene 
	box.disabled = false
	print("Player:", player)


func _process(delta: float) -> void:
	if global.arcade_door == false:
		if interactable and Input.is_action_just_pressed("interact") && global.is_switching == false:
			
			var transition = preload("res://scenes/transition_manager.tscn").instantiate()
			get_tree().root.add_child(transition)
			transition.start_transition(global.new_scene_placement)
			global.input_disabled = true
			global.is_switching = true
			#get_tree().change_scene_to_file(next_scene)
	elif interactable and Input.is_action_just_pressed("interact"):
		run_dialogue(dialogue)
		box.disabled = true
		

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # Only allow Player to trigger
		interactable = true
		popup.visible = true 
		
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		interactable = false
		popup.visible = false
		
func run_dialogue(dialogue_string):
		# Enable glitch
	
	shader_mesh.material.set_shader_parameter("glitch_enabled", true)
	
	# Play glitch sound alongside dialogue
	glitch_sfx.stop()
	glitch_sfx.play()

	# Start dialogue immediately
	Dialogic.start(dialogue_string)
	
	# When sound finishes, stop glitch effect
	await get_tree().create_timer(40.0).timeout
	shader_mesh.material.set_shader_parameter("glitch_enabled", false)
