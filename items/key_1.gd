extends CharacterBody2D


@export var dialog: String
@export var chatbox: CollisionShape2D
@export var player: CharacterBody2D
var player_in_area = false


func _physics_process(delta: float) -> void:
		if player_in_area == true:
				chatbox.disabled = true
			



func _on_chatdetection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true 
		


func _on_chatdetection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false 
