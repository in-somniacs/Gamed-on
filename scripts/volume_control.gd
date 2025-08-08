extends Control
@onready var master: HSlider = $options/VBoxContainer/master
@onready var sfx: HSlider = $options/VBoxContainer/sfx
@onready var music: HSlider = $options/VBoxContainer/music



func _ready():
	# Sync sliders with current bus volumes
	master.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	music.value  = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	sfx.value    = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("sfx"))
	

func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)


func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), value)


func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
