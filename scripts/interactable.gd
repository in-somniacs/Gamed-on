extends Area2D
@onready var hint: RichTextLabel = $RichTextLabel


@onready var player: CharacterBody2D = get_node("../Player")
@onready var floor_0: Node2D = get_node("../stairs/floor_0")
@onready var floor_1: Node2D = get_node("../stairs/floor_1")

var interactable = false

func _ready():
	# Debug: Make sure the nodes are found correctly
	print("Player:", player)
	print("Floor 0:", floor_0)
	print("Floor 1:", floor_1)

func _process(delta: float) -> void:
	if interactable and Input.is_action_just_pressed("interact"):
		player.global_position = floor_1.global_position
		print("Teleported to:", floor_1.global_position)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # Only allow Player to trigger
		interactable = true
		hint.visible = true 
		

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		interactable = false
		hint.visible = false
