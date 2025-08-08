extends Control
@onready var menu: MarginContainer = $menu
@onready var options: MarginContainer = $options
@onready var next_scene: String = "res://scenes/rooms/room_0.tscn"
@onready var particles: GPUParticles2D = $menu_particles/GPUParticles2D

var isplaying = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		#get_tree().change_scene_to_file("res://scenes/rooms/room_0.tscn")
		

func _on_options_button_pressed() -> void:
	menu.visible = false
	options.visible = true

func _on_back_pressed() -> void:
	menu.visible = true
	options.visible = false


func _on_play_button_pressed() -> void:
	var transition = preload("res://scenes/transition_manager.tscn").instantiate()
	get_tree().root.add_child(transition)
	transition.start_transition("res://scenes/rooms/room_0.tscn")
	particles.explosiveness = 19
	particles.emitting = false
	

	
	
