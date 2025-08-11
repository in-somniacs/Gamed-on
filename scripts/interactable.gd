extends Node2D
@export var player: CharacterBody2D 
@export var dialogue: String
@export var chatbox: CollisionShape2D
@export var achieve: RichTextLabel
@export var anim: AnimationPlayer
@export var panel: Panel
@export var audio: AudioStreamPlayer2D
@export var name_ach: String
@export var ani: AnimationPlayer
@export var popup: NinePatchRect

@onready var inv = preload("res://items/inventory.tres")

var player_in_area = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.new_scene_placement = "res://scenes/rooms/footpath.tscn"
	preload_achievement()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if  global.set_console == true:
		if player_in_area:
			chatbox.disabled = false
			if Input.is_action_pressed("dialogic_default_action"):
				run_dialogue(dialogue)
				global.canmove =false
				chatbox.disabled = true
				global.new_scene_placement = "res://scenes/room_1(entry_corridor).tscn"
				ResourceSaver.save(inv)
				#global.console_set = true
				

	else:
		chatbox.disabled = true
				
	inv.items[0] = null
	
	if Dialogic.VAR.console_set:
		global.console_set = true

			
			
func _on_chatdetection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		popup.visible = true
		
func _on_chatdetection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false 
		popup.visible = false
		
		
		

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
	#add_child(dlg)
	#dlg.choice_selected.connect(_on_choice_selected)
	Dialogic.timeline_ended.connect(_on_dialogue_end)


func _on_dialogue_end():
	
	Dialogic.timeline_ended.disconnect(_on_dialogue_end)
	global.canmove = true

	ani.play("hours_fadein")
	await get_tree().create_timer(5.0).timeout
	ani.play("hours_faddeout")
	achiement_sound()

func achiement_sound():
	achieve.visible = true
	panel.visible = true
	audio.stream = preload("res://assets/sfx/achievement.wav")
	anim.play("fade_pin")
	audio.play()
	await get_tree().create_timer(2.5).timeout
	anim.play("fade_put")
func preload_achievement():
	achieve.visible = false
	panel.visible = false
	achieve.text = name_ach

#func _on_choice_selected(index: int, text: String):
	#if text.to_lower() == "place console":
		#global.console_set = true
