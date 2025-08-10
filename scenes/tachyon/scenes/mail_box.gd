extends Node2D


@export var player: CharacterBody2D 
@export var dialogue: String
@onready var chatbox: CollisionShape2D = $Chatdetection/chatbox
@export var popup: NinePatchRect
@onready var shader_mesh : MeshInstance2D = $"../../../CanvasLayer/crt and glitch"
@onready var inv = preload("res://items/inventory.tres")



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
	ResourceSaver.save(inv)
			
			
			
func _on_chatdetection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		popup.visible = true
		
func _on_chatdetection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false 
		popup.visible = false
		
		
		

func run_dialogue(dialogue_string):
	# Enable glitch
#	shader_mesh.material.set_shader_parameter("glitch_enabled", true)
	Dialogic.start(dialogue_string)
	# Listen for end of dialogue
	Dialogic.timeline_ended.connect(_on_dialogue_end)
	
	

func _on_dialogue_end():
	#shader_mesh.material.set_shader_parameter("glitch_enabled", false)
	Dialogic.timeline_ended.disconnect(_on_dialogue_end)

	

func _on_respawn_chat_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		pass
		
func _on_respawn_chat_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
