extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global.game_first_loadin == true:
		$Player.position.x = global.player_startx
		$Player.position.y = global.player_starty
	else:
		$Player.position.x = global.player_exit_roomx
		$Player.position.y = global.player_exit_roomy
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scene()


func _on_room_enter_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = true


func _on_room_enter_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/keyroom.tscn")
			global.game_first_loadin = false
			global.finish_change_scene()
		
