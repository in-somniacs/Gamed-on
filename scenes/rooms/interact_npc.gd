extends Node2D


@export var player: CharacterBody2D 
@export var dialogue: String
@export var textholder: RichTextLabel

var interact = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textholder.visible = false
	textholder.text = dialogue


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if interact && Input.is_action_just_pressed("interact"):
		textholder.visible = true
		
	
	
func _on_body_entered(body: Node2D) -> void:
	
	interact = true


func _on_body_exited(body: Node2D) -> void:
	interact = false
	
