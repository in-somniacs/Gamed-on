extends Area2D

const PLAYER = preload("res://scenes/minigame/minigane1/scenes/player_minigame1.tscn")
@export var anim: AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	print("death")
	global.minigame = true
	await get_tree().create_timer(0.2).timeout
	get_tree().reload_current_scene()
	
	

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
	
