extends Node2D


@export var player: CharacterBody2D 
@export var dialogue: String
@export var chatbox: CollisionShape2D
@export var achieve: RichTextLabel
@export var anim: AnimationPlayer
@export var panel: Panel
@export var audio: AudioStreamPlayer2D
@export var name_ach: String
@export var ani: AnimationPlayer
@export var popup: NinePatchRect
@onready var inv = preload("res://items/inventory.tres")
@export var shader_mesh : MeshInstance2D 
@export var glitch_sfx : AudioStreamPlayer2D 
var player_in_area = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.new_scene_placement = "res://scenes/rooms/footpath.tscn"
	preload_achievement()
	shader_mesh.material.set_shader_parameter("crt_enabled", false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if  global.set_console == true:
		if player_in_area:
			if Input.is_action_pressed("dialogic_default_action"):
				run_dialogue(dialogue)
				chatbox.disabled = true
				global.canmove = false
				global.new_scene_placement = "res://scenes/room_1(entry_corridor).tscn"
	else:
		chatbox.disabled = true
			
			
func _on_chatdetection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		popup.visible = true
		
func _on_chatdetection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false 
		popup.visible = false
	global.canmove = true
		
		

func run_dialogue(dialogue_string):
	# Enable glitch
	#await get_tree().create_timer(2.0).timeout
	shader_mesh.material.set_shader_parameter("glitch_enabled", true)
	
	# Play glitch sound alongside dialogue
	glitch_sfx.stop()
	glitch_sfx.play()

	# Start dialogue immediately
	Dialogic.start(dialogue_string)
	
	# When sound finishes, stop glitch effect
	await get_tree().create_timer(10.0).timeout
	shader_mesh.material.set_shader_parameter("glitch_enabled", false)
	shader_mesh.material.set_shader_parameter("crt_enabled", true)
	

func _on_dialogue_end():
	shader_mesh.material.set_shader_parameter("glitch_enabled", false)
	Dialogic.timeline_ended.disconnect(_on_dialogue_end)
	
	ani.play("hours_fadein")
	await get_tree().create_timer(5.0).timeout
	ani.play("hours_faddeout")
	achiement_sound()


func _on_respawn_chat_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		pass
		
func _on_respawn_chat_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
	
func achiement_sound():
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
