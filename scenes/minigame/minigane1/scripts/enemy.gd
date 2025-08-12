extends Node2D

@onready var ray_cast_left: RayCast2D = $Area2D/RayCastleft
@onready var ray_cast_right: RayCast2D = $Area2D/RayCastRight
@onready var animated_sprite: Sprite2D = $Sprite2D



const speed = 60
var dir = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		dir = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		dir = 1
		animated_sprite.flip_h = false
	position.x += dir * speed * delta




func _on_static_body_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
