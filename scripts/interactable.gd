extends Area2D


@onready var player: CharacterBody2D = $"../player"




@onready var hint: RichTextLabel = $RichTextLabel


var interatable = false
func _process(delta: float) -> void:
	if interatable == true && Input.is_action_just_pressed("interact"):
		print("interacted")



	
func _on_body_entered(body: Node2D) -> void:
	interatable = true
	hint.visible = true


func _on_body_exited(body: Node2D) -> void:
	interatable = false
	hint.visible = false
