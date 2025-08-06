extends Area2D
@export var hint: RichTextLabel 
@export var player: CharacterBody2D 
@export var next_scene: String 


var interactable = false

func _ready():
	# Debug: Make sure the nodes are found correctly

	print("Player:", player)


func _process(delta: float) -> void:
	if interactable and Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file(next_scene)
		

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # Only allow Player to trigger
		interactable = true
		hint.visible = true 
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		interactable = false
		hint.visible = false
