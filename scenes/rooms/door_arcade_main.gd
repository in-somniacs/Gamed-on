extends Area2D

@export var dialogue: String
@export var player: CharacterBody2D
@export var popup: NinePatchRect
@export var destination: Node2D
@export var ani: AnimationPlayer
@export var chatbox: CollisionShape2D
var player_in_area = false
var player_area = false

func _ready() -> void:
			global.teleportdoor = false
func _physics_process(delta: float) -> void:
		if player_in_area == true && Input.is_action_pressed("dialogic_default_action") && global.teleportdoor == true:
			ani.play("fade_in")
			player.global_position = destination.global_position
			ani.play("fade_out")
			
		if player_in_area:
			if Input.is_action_pressed("dialogic_default_action") :
				run_dialogue(dialogue)
				chatbox.disabled = true
				global.canmove = false


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player")  && global.teleportdoor == true:
		popup.visible = true
		player_in_area = true

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player")  && global.teleportdoor == true:
		popup.visible = false
		player_in_area = false

func run_dialogue(dialogue_string):
	# Enable glitch
	#shader_mesh.material.set_shader_parameter("glitch_enabled", true)
	
	# Play glitch sound alongside dialogue
	#glitch_sfx.stop()
	#glitch_sfx.play()

	# Start dialogue immediately
	Dialogic.start(dialogue_string)
	Dialogic.timeline_ended.connect(_on_dialogue_end)
	
	# When sound finishes, stop glitch effect
	await get_tree().create_timer(10.0).timeout
	#shader_mesh.material.set_shader_parameter("glitch_enabled", false)
	

func _on_dialogue_end():
	#shader_mesh.material.set_shader_parameter("glitch_enabled", false)
	Dialogic.timeline_ended.disconnect(_on_dialogue_end)
	global.canmove = true


func _on_chatdetection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = true
		player_in_area = true


func _on_chatdetection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = false
		player_in_area = false
