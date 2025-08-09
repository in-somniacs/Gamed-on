extends Control
@onready var inventory: In = preload("res://items/inventory.tres")
@onready var slots: Array = $NinePatchRect/HBoxContainer/GridContainer.get_children()
var isopen = false

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
	
func _ready() -> void:
	update()
	close()
func open():
	visible = true
	isopen = true
	Engine.time_scale = 0

func close():
	Engine.time_scale = 1
	isopen = false
	visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("inventory") && isopen == true:
			close()
	elif Input.is_action_pressed("inventory") && isopen == false:
			open()
