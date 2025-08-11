extends Panel

@onready var backdrop: Sprite2D = $backdrop
@onready var item_: Sprite2D = $CenterContainer/Panel/item
var INVENTORY = preload("res://items/inventory.tres")
var inv = preload("res://scenes/ui/invenory.tscn")

func update(item: inventoryItem):
		if !item:
			backdrop.frame = 0
			item_.visible = false
		else:
			backdrop.frame = 1
			item_.visible = true
			item_.texture = item.texture
func _ready() -> void:
	pass
			
