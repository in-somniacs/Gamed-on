extends Node2D

@export var glitch_material: MeshInstance2D
@export var dialogue: String
@export var jump: Panel
@export var aldi: AudioStreamPlayer2D
@export var ani: AnimatedSprite2D

var player_in_area = false


func _ready() -> void:
	global.new_scene_placement ="res://scenes/Credits.tscn"
	jump.visible = false
	
	aldi.stream = preload("res://assets/sfx/jump_me_daddy.mp3")
	# Make sure glitch is off at start (optional — remove if Dialogic handles it fully)
	global.glitch_enabled = false
	var glitch_node = $CanvasLayer2/"crt and glitch"
	global.glitch_material = glitch_node.material

#ok
func _process(delta: float) -> void:
	if glitch_material and glitch_material.material:
		var mat = glitch_material.material
		if mat is ShaderMaterial:
			mat.set_shader_parameter("glitch_enabled", global.glitch_enabled)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not player_in_area:
		player_in_area = true
		run_dialogue()

func run_dialogue():
	Dialogic.start(dialogue)
	Dialogic.timeline_ended.connect(_on_dialogue_end)

func _on_dialogue_end():
	Dialogic.timeline_ended.disconnect(_on_dialogue_end)
	global.disable_player_movement()
	ani.play("death")
	global.enable_glitch()
	
	await get_tree().create_timer(2).timeout
	aldi.play()
	jump.visible = true
	await get_tree().create_timer(2.5).timeout
	
	var transition = preload("res://transition_manager_finale.tscn").instantiate()
	global.disable_glitch()
	get_tree().root.add_child(transition)
	transition.start_transition(global.new_scene_placement)
	global.is_switching = true
	
	

func _on_static_body_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not player_in_area:
		player_in_area = true
		run_dialogue()

func _on_static_body_2d_body_exited(body: Node2D) -> void:
	pass
