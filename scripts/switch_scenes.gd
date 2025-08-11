extends Area2D
@export var hint: RichTextLabel 
@export var player: CharacterBody2D 
@export var next_scene: String 
@export var popup: NinePatchRect



var interactable = false

func _ready():
	global.new_scene_placement = next_scene 

	print("Player:", player)


func _process(delta: float) -> void:
		if interactable and Input.is_action_just_pressed("interact") && global.is_switching == false:
			
			var transition = preload("res://scenes/transition_manager.tscn").instantiate()
			get_tree().root.add_child(transition)
			transition.start_transition(global.new_scene_placement)
			global.input_disabled = true
			global.is_switching = true
			#get_tree().change_scene_to_file(next_scene)

		

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # Only allow Player to trigger
		interactable = true
		popup.visible = true 
		
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		interactable = false
		popup.visible = false
		
