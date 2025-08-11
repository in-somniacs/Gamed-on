extends CanvasLayer
@export var crt_and_glitch: CanvasLayer
@export var mom: CharacterBody2D
@export var shader_mesh: MeshInstance2D
@export var glitch_sfx: AudioStreamPlayer2D
@export var dialogue: String

var glitch_running = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	crt_and_glitch.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if global.crt_enabled == true:
		#crt_and_glitch.visible = true
		##mom.queue_free()
		#shader_mesh.material.set_shader_parameter("glitch_enabled", true)
	#else:
		#pass
	if global.crt_enabled and not glitch_running:
		glitch_running = true
		start_glitch_sequence()
		
func start_glitch_sequence():
	crt_and_glitch.visible = true

	shader_mesh.material.set_shader_parameter("glitch_enabled", true)

	glitch_sfx.play()
	await get_tree().create_timer(1.0).timeout
	Dialogic.start(dialogue)
	await get_tree().create_timer(10.0).timeout
	shader_mesh.material.set_shader_parameter("glitch_enabled", false)
	mom.queue_free()

		
