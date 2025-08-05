extends Area2D
@onready var hint: RichTextLabel = $hint
@onready var player: CharacterBody2D = $"../Player"
@onready var floor_0: Node2D = $"../stairs/floor_0"
@onready var floor_1: Node2D = $"../stairs/floor_1"



var floor0: Vector2
var floor1: Vector2
var interactable = false

func _ready():
	floor0 = floor_0.global_position
	floor1 = floor_1.global_position

func _process(delta: float) -> void:
	if interactable and Input.is_action_just_pressed("interact"):
		player.global_position = floor1  # or floor0 depending on your logic
		print("Teleported to:", floor1)

func _on_body_entered(body: Node2D) -> void:
	interactable = true
	hint.visible = true

func _on_body_exited(body: Node2D) -> void:
	interactable = false
	hint.visible = false
