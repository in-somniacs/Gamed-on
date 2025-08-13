extends Control
@export var achieve: RichTextLabel
@export var anim: AnimationPlayer
@export var panel: Panel
@export var audio: AudioStreamPlayer2D
@export var name_ach: String
@export var popup: NinePatchRect
@export var chatbox: CollisionShape2D
@export var shader_mesh : MeshInstance2D 
@export var glitch_sfx : AudioStreamPlayer2D 
@export var jumpscare_image : TextureRect
@export var dialogue: String
@export var jump: VideoStreamPlayer
var loaded = false
var player_in_area = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	preload_achievement()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area:
		chatbox.disabled = false
		if Input.is_action_pressed("dialogic_default_action"):
			jump.play()
			chatbox.disabled = true
			await get_tree().create_timer(2).timeout
			achiement_sound()



#func run_dialogue(dialogue_string):
	## Optional: start with no glitch so player relaxes
	#shader_mesh.material.set_shader_parameter("glitch_enabled", false)
#
	## Connect to end signal
	#if not Dialogic.timeline_ended.is_connected(_on_dialogue_end):
		#Dialogic.timeline_ended.connect(_on_dialogue_end)
#
	## Start dialogue
	#Dialogic.start(dialogue_string)
#
#func _on_dialogue_end():
	## Trigger the jump scare
	#shader_mesh.material.set_shader_parameter("glitch_enabled", true)
	#glitch_sfx.stop()
	#glitch_sfx.play()
#
	## Show the big distorted image
	#jumpscare_image.visible = true
	#jumpscare_image.modulate.a = 1.0  # fully visible
#
	## Wait briefly, then hide it and end glitch
	#await get_tree().create_timer(0.4).timeout
	#jumpscare_image.visible = false
	#shader_mesh.material.set_shader_parameter("glitch_enabled", false)
#
	## Disconnect to avoid multiple triggers
	#Dialogic.timeline_ended.disconnect(_on_dialogue_end)


func achiement_sound():
	loaded = true
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


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		popup.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
		popup.visible = false
