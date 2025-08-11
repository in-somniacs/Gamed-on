extends Node2D

@onready var player: CharacterBody2D = $Player

var start_dia = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	if not global.has_played_room_intro:
		global.canmove = false
		global.has_played_room_intro = true			
			
		await get_tree().create_timer(4.0).timeout

		var dialog_node = Dialogic.start("res://timelines/roomentry1.dtl")
		dialog_node.connect("timeline_end", Callable(self, "_on_dialogue_finished"))
		




func _on_dialogue_finished():
	global.canmove = true




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Dialogic.current_timeline == null && not global.canmove:
		_on_dialogue_finished()


func _input(event: InputEvent) -> void:
	if Dialogic.current_timeline != null:
		return
	
	if event is InputEventKey and event.keycode == KEY_C and event.pressed:
		Dialogic.start("res://timelines/roomspawntimeline.dtl")
		get_viewport().set_input_as_handled()
		
