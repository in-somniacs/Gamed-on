extends Node


var y = [
			preload("res://assets/sfx/footstep1.wav"),
			preload("res://assets/sfx/footstep2.wav"),
			preload("res://assets/sfx/footstep3.wav")
			]
func playfoot(position: Vector2):
		var x = y.pick_random()
		var audio_player = AudioStreamPlayer2D.new()
		audio_player.stream = x
		get_tree().root.add_child(audio_player)
		audio_player.global_position = position
		audio_player.play()
		await audio_player.finished
		audio_player.queue_free()
