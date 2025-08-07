extends Node2D

const DialogueButtonPreload = preload("res://scenes/tachyon/scenes/dialogue_button.tscn")
@onready var DialogueLabel: RichTextLabel = $HBoxContainer/VBoxContainer/RichTextLabel
@onready var SpeakerSprite: Sprite2D = $HBoxContainer/SpeakerParent/Sprite2D

var dialogue: Array[DE]
var current_dialogue_item: int = 0
var next_item: bool = true

var player_node: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	$"HBoxContainer/VBoxContainer/Button_container".visible = false
	
	for i in get_tree().get_nodes_in_group("player"):
		player_node = i
		

func _process(_delta: float) -> void:
	if current_dialogue_item == dialogue.size() - 1:
		if !player_node:
			for i in get_tree().get_nodes_in_group("player"):
				player_node = i
				return
		player_node.can_move = true
		queue_free()
		return
		
	if next_item:
		next_item = false
		var i = dialogue[current_dialogue_item]

	if i is DialogueFunction:
		if i.hide_dialogue_box:
			visible = false
		else:
			visible = true
		_function_resource(i)

	elif i is DialogueChoice:
		visible = true
		_choice_resource(i)

	elif i is DialogueText:
		visible = true
		_text_resource(i)

	else:
		printerr("You accidentally added a DE resource!")

	current_dialogue_item += 1
	next_item = true



func _function_resource(i: DialogueFunction) -> void:
	var target_node = get_node(i.target_path)
	if target_node.has_method(i.function_name):
		if i.function_arguments.size() == 0:
			target_node.call(i.function_name)
		else:
			target_node.callv(i.function_name, i.function_arguments)

	if i.wait_for_signal_to_continue:
		var signal_name = i.wait_for_signal_to_continue
		if target_node.has_signal(signal_name):
			var signal_state = { "done": false }
			var callable = func(_args): signal_state.done = true
			target_node.connect(signal_name, callable, CONNECT_ONE_SHOT)
			while not signal_state.done:
				await get_tree().process_frame
		
		current_dialogue_item += 1
		next_item = true

func _choice_resource(i: DialogueChoice) -> void:
	# set speaker name here as well!
	DialogueLabel.text = i.text
	DialogueLabel.visible_characters = -1

	if i.speaker_img:
		$HBoxContainer/SpeakerParent.visible = true
		SpeakerSprite.texture = i.speaker_img
		SpeakerSprite.hframes = i.speaker_img_Hframes
		SpeakerSprite.frame = min(i.speaker_img_select_frame, i.speaker_img_Hframes - 1)
	else:
		$HBoxContainer/SpeakerParent.visible = false
	$HBoxContainer/VBoxContainer/Button_container.visible = true


func _text_resource(i: DialogueText) -> void:
	pass


 
