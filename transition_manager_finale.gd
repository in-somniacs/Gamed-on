extends CanvasLayer
@onready var fade_rect: ColorRect = $ColorRect

@onready var quote_label: Label = $ColorRect/quote

@onready var load_delay: Timer = $load_delay
@onready var loading: Label = $ColorRect/loading
@onready var anim: AnimationPlayer = $AnimationPlayer

@export var next_scene_path: String
var quotes = [
	"",
	""
	
]

var load = [
	"",
	"",
	"",
	""
	
]

func start_transition(next_scene_path: String):
	anim.play("fade_in")
	

	await anim.animation_finished
	get_tree().change_scene_to_file(next_scene_path)
	#next_scene_path = scene_path

	# Pick a random quote
	quote_label.text = quotes[randi() % quotes.size()]
	quote_label.visible = true

	## Fade to black
	#fade_rect.modulate.a = 0
	#create_tween().tween_property(fade_rect, "modulate:a", 1.0, 1.5)
	##loading animation
	#for i in range(4):
		#await get_tree().create_timer(0.5).timeout # Delay for 0.5 seconds
		#loading.text = load[i]
		#
	
	# Wait a bit, then load
	#load_delay.start(3.5)

#func _on_load_delay_timeout():
	#get_tree().change_scene_to_file(next_scene_path)
	#fade_rect.queue_free()
	#quote_label.queue_free()
	#loading.queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		# Start timer for the delay
		load_delay.start(1.5)  # 2 seconds delay

func _on_load_delay_timeout() -> void:
	anim.play("fade_out")
	
