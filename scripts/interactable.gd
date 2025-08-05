extends Area2D


@onready var player: CharacterBody2D = $"../player"

@onready var floor_0: Node2D = $"../teleportpoints/floor_0"
@onready var floor_1: Node2D = $"../teleportpoints/floor_1"


@onready var hint: RichTextLabel = $RichTextLabel


var interatable = false
func _ready() -> void:
	pass	
	
func _process(delta: float) -> void:
	var floor1 = floor_1.global_position
	var floor0 = floor_0.global_position
	if interatable == true && Input.is_action_just_pressed("interact"):
		print(floor1)

func _on_body_entered(body: Node2D) -> void:
	interatable = true
	hint.visible = true


func _on_body_exited(body: Node2D) -> void:
	interatable = false
	hint.visible = false
