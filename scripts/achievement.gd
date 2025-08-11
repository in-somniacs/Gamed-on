extends Control
@export var achieve: RichTextLabel
@export var anim: AnimationPlayer
@export var panel: Panel
@export var audio: AudioStreamPlayer2D
@export var name_ach: String
var loaded = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	preload_achievement()
	await get_tree().create_timer(2.0).timeout
	achiement_sound()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if loaded == false:
		pass
	else:
		pass

func achiement_sound():
	loaded = true
	achieve.visible = true
	panel.visible = true
	audio.stream = preload("res://assets/sfx/achievement.wav")
	anim.play("fade_pin")
	audio.play()
	await get_tree().create_timer(2.5).timeout
	anim.play("fade_put")
	
func preload_achievement():
	achieve.visible = false
	panel.visible = false
	achieve.text = name_ach
