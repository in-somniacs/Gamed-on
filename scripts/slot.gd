extends Panel

@onready var backdrop: Sprite2D = $backdrop
@onready var item_: Sprite2D = $CenterContainer/Panel/item

func update(item: inventoryItem):
		if !item:
			backdrop.frame = 0
			item_.visible = false
		else:
			backdrop.frame = 1
			item_.visible = true
			item_.texture = item.texture
			
