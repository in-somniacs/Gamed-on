extends CharacterBody2D

@export var next_scene: String
@export var player: CharacterBody2D 
@export var popup: NinePatchRect
@export var timeline: String

@onready var chatbox: CollisionShape2D = $Chatdetection/chatbox
#@onready var res_chat: CollisionPolygon2D = $respawn_chat/res_chat


var player_in_area = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	popup.visible = false
	global.new_scene_placement = next_scene 
	global.is_switching =false

	print("Player:", player)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_in_area:
		if Input.is_action_pressed("dialogic_default_action") && global.is_switching == false && global.arcade_game == true:
			var transition = preload("res://scenes/transition_manager.tscn").instantiate()
			get_tree().root.add_child(transition)
			
			#run_dialogue(timeline) add dialogue layer peeju
			chatbox.disabled = true
			transition.start_transition(global.new_scene_placement)
			global.input_disabled = true
			global.is_switching = true
		else:
			pass
			
			
			
func _on_chatdetection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		popup.visible = true
		
		
func _on_chatdetection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false 
		popup.visible = false
		
		
		

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
	

func _on_respawn_chat_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		pass
		
func _on_respawn_chat_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
