extends Panel

@onready var backdrop: Sprite2D = $backdrop
@onready var item_: Sprite2D = $CenterContainer/Panel/item
@onready var tooltip_label: Label = $Label
var INVENTORY = preload("res://items/inventory.tres")
var inv = preload("res://scenes/ui/invenory.tscn")
var item = preload("res://items/ps.tres")

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
			
func _on_mouse_entered() -> void:
	if InventoryItem:
		print()
		tooltip_label.text = "[b]%s[/b]\n%s" % [item.title,  item.info]
		tooltip_label.visible = true
		tooltip_label.global_position = get_global_mouse_position() + Vector2(16, 16)


func _on_mouse_exited() -> void:
	tooltip_label.visible = false
