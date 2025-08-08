extends CanvasLayer


@onready var particles: GPUParticles2D = $GPUParticles2D


func _ready():
	particles.position = get_viewport().size / 2  # center of screen
