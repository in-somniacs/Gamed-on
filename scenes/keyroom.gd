extends Node2D
@export var dialogue: String 
@export var shader_mesh: MeshInstance2D
@export var glitch_sfx: AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scene()


func _on_cliff_exitpoint_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = true
		


func _on_cliff_exitpoint_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = false
		


func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "cliff-side":
			get_tree().change_scene_to_file("res://scenes/room_1(entry_corridor).tscn")
			global.finish_change_scene()
