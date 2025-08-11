extends Area2D

@export var itemRes: inventoryItem

func collect(inventory: In):
	inventory.insert(itemRes)
	queue_free()
	
