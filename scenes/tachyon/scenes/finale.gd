extends Node2D

@export var glitch_material: MeshInstance2D
@export var dialogue: String
@export var jump: Panel
@export var aldi: AudioStreamPlayer2D
@export var ani: AnimatedSprite2D
var player_in_area = false


func _ready() -> void:
	jump.visible = false
	aldi.stream = preload("res://assets/sfx/jump_me_daddy.mp3")
	# Make sure glitch is off at start (optional — remove if Dialogic handles it fully)
	global.glitch_enabled = false

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
	ani.play("death")
	global.disable_player_movement()

func _on_static_body_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not player_in_area:
		player_in_area = true
		run_dialogue()

func _on_static_body_2d_body_exited(body: Node2D) -> void:
	pass
