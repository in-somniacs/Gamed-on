extends DE
class_name DialogueFunction

@export var target_path: NodePath
@export var function_name: String
@export var function_arguments: Array

@export var hide_dialogue_box: bool
@export var wait_for_signal_to_continue: String = ""



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
