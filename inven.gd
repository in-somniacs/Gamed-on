extends Resource

class_name In
signal updated

@export var items: Array[inventoryItem]
func insert(item: inventoryItem):
	for i in range(items.size()):
		if !items[i]:
			items[i] = item
			break
	updated.emit()
