extends Node2D

@export var glitch_material: MeshInstance2D
@export var dialogue: String

var player_in_area = false

func _ready() -> void:
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

func _on_static_body_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not player_in_area:
		player_in_area = true
		run_dialogue()

func _on_static_body_2d_body_exited(body: Node2D) -> void:
	pass
