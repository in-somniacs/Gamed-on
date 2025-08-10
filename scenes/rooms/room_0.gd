extends Node2D

@onready var player: CharacterBody2D = $Player




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not global.has_played_room_intro:
		global.has_played_room_intro = true
		await get_tree().create_timer(5.0).timeout
		Dialogic.start("res://timelines/roomentry1.dtl")




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if Dialogic.current_timeline != null:
		return
	
	if event is InputEventKey and event.keycode == KEY_C and event.pressed:
		Dialogic.start("res://timelines/roomspawntimeline.dtl")
		get_viewport().set_input_as_handled()
		

		
		
		
		
		
		
