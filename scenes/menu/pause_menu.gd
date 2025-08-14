extends Control
@onready var pause_menu: Control = $"."
@onready var panel: Panel = $Panel
@onready var options: MarginContainer = $options

var is_paused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") && is_paused == false:
		pause()
		is_paused = true
	elif Input.is_action_just_pressed("pause") && is_paused == true:
		is_paused = false
		resume()

	

func pause():
	Engine.time_scale = 0
	pause_menu.visible = true
	
func resume():
	Engine.time_scale = 1
	pause_menu.visible = false


func _on_resume_pressed() -> void:
	resume()


func _on_button_2_pressed() -> void:
	panel.visible = false
	options.visible = true


func _on_back_pressed() -> void:
	panel.visible = true
	options.visible = false


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
