extends Control
@export var achieve: RichTextLabel
@export var anim: AnimationPlayer
@export var panel: Panel
@export var audio: AudioStreamPlayer2D
@export var name_ach: String
@export var popup: NinePatchRect
@export var chatbox: CollisionShape2D
var loaded = false
var player_in_area = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	preload_achievement()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area:
		chatbox.disabled = false
		if Input.is_action_pressed("dialogic_default_action"):
			achiement_sound()
			chatbox.disabled = true


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


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		popup.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
		popup.visible = false
