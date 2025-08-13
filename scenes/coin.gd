extends Area2D


@export var dialog: String
@export var chatbox: CollisionShape2D
@export var player: CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var popup: NinePatchRect
var player_in_area = false


func _physics_process(delta: float) -> void:
		if global.coin_total == 5:
			global.arcade_game = true
		if player_in_area == true && Input.is_action_pressed("dialogic_default_action"):
				chatbox.disabled = true
				sprite.visible = false
				global.arcade_door = false
				global.coin_total += 1
			
func _on_chatdetection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true 
		popup.visible = true
		


func _on_chatdetection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false 
		popup.visible = false
