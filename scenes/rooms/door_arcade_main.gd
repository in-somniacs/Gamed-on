extends Area2D

@export var dialog: String
@export var player: CharacterBody2D
@export var popup: NinePatchRect
@export var destination: Node2D
@export var ani: AnimationPlayer
var player_in_area = false

func _ready() -> void:
			global.teleportdoor = false
func _physics_process(delta: float) -> void:
		if player_in_area == true && Input.is_action_pressed("dialogic_default_action") && global.teleportdoor == true:
			ani.play("fade_in")
			player.global_position = destination.global_position
			ani.play("fade_out")


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = true
		player_in_area = true

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = false
		player_in_area = false
