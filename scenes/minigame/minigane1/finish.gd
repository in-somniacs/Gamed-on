extends Area2D
@export var player: CharacterBody2D 
@export var next_scene: String 
@export var popup: NinePatchRect



var interactable = false

func _ready():
	global.new_scene_placement = next_scene 
	global.is_switching =false

	print("Player:", player)


func _process(delta: float) -> void:
		if global.is_switching == false and interactable == true:
			
			var transition = preload("res://scenes/transition_manager.tscn").instantiate()
			get_tree().root.add_child(transition)
			transition.start_transition(global.new_scene_placement)
			global.input_disabled = true
			global.is_switching = true
			#get_tree().change_scene_to_file(next_scene)

		

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		interactable = true


		
func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		interactable = false
