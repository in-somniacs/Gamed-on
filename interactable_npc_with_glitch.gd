extends Node2D


@export var player: CharacterBody2D 
@export var dialogue: String
@onready var chatbox: CollisionShape2D = $Chatdetection/chatbox
@onready var res_chat: CollisionPolygon2D = $respawn_chat/res_chat
@export var popup: NinePatchRect
@export var shader_mesh : MeshInstance2D 
@export var glitch_sfx : AudioStreamPlayer2D 
var player_in_area = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area:
		if Input.is_action_pressed("dialogic_default_action"):
			run_dialogue(dialogue)
			chatbox.disabled = true
			global.canmove = false
			
			
			
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
	
	shader_mesh.material.set_shader_parameter("glitch_enabled", true)
	
	# Play glitch sound alongside dialogue
	glitch_sfx.stop()
	glitch_sfx.play()

	# Start dialogue immediately
	Dialogic.start(dialogue_string)
	
	# When sound finishes, stop glitch effect
	await get_tree().create_timer(10.0).timeout
	shader_mesh.material.set_shader_parameter("glitch_enabled", false)
	

func _on_dialogue_end():
	shader_mesh.material.set_shader_parameter("glitch_enabled", false)
	Dialogic.timeline_ended.disconnect(_on_dialogue_end)


func _on_respawn_chat_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		pass
		
func _on_respawn_chat_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
