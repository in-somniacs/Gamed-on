extends Panel
@export var next_scene: String 


func _on_button_3_pressed() -> void:
	Engine.time_scale = 1
	var transition = preload("res://scenes/transition_manager.tscn").instantiate()
	get_tree().root.add_child(transition)
	transition.start_transition(next_scene)
