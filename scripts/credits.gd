extends Control

@onready var fader = $ColorRect
@onready var credits = $VBoxContainer

# ====== SETTINGS ======
@export var scroll_speed: float = 40.0
@export var end_scene_path: String = "res://scenes/menu/main_menu.tscn"
@export var ani: AnimationPlayer
@export var audio:AudioStreamPlayer
# Font settings
@export var font_path: String = "res://assets/font/PixelifySans-VariableFont_wght.ttf"
@export var title_size: int = 42
@export var subtitle_size: int = 24
@export var heading_size: int = 28
@export var subheading_size: int = 22
@export var normal_size: int = 18

# Font colors
@export var title_color: Color = Color.WHITE
@export var subtitle_color: Color = Color.WHITE
@export var heading_color: Color = Color.YELLOW
@export var subheading_color: Color = Color.LIGHT_GRAY
@export var normal_color: Color = Color.WHITE

# Extra gap between lines
@export var extra_spacing: int = 14

var started = false
var custom_font: FontFile

func _ready():
	# Load font once (Godot 4 way)
	custom_font = load(font_path)
	if custom_font == null:
		push_warning("Font not found, using default font.")
	
	_add_credits_text()
	audio.stream = preload("res://assets/music/credits.mp3")
	fader.modulate.a = 1.0
	
	await get_tree().create_timer(2).timeout
	_fade_in()

	

func _fade_in():
	var t = create_tween()
	t.tween_property(fader, "modulate:a", 0.0, 1.5)
	t.tween_callback(_start_scroll)

func _add_credits_text():
	var credits_text = [
		["[REDACTED]", "TITLE"],
		["", "NORMAL"],
		["", "NORMAL"],
		["", "NORMAL"],
		["", "NORMAL"],
		["", "NORMAL"],
		["", "NORMAL"],
		["", "NORMAL"],
		["", "NORMAL"],
		["A Game by a6h1 & masuwuked", "SUBTITLE"],
		["Created for Gamedeon — IIT Guwahati", "NORMAL"],
		["", "NORMAL"],
		["Themes Used", "HEADING"],
		["Unreliable Narrator: you could never trust him...", "NORMAL"],
		["Stuck Together: your soul is now stuck with everyone in the console....", "NORMAL"],
		["", "NORMAL"],
		["About This Game", "HEADING"],
		["This was our very first game\n created in just 10 days for the Gamedeon Game Jam.\nWith almost no prior experience in game development\n we dove headfirst into learning, creating, and debugging.\nEvery challenge became a lesson, and every late night was worth it.", "NORMAL"],
		["", "NORMAL"],
		["Development Team", "HEADING"],
		["Game Design & Programming", "SUBHEADING"],
		["a6h1", "NORMAL"],
		["masuwuked", "NORMAL"],
		["", "NORMAL"],
		["Story & Concept", "SUBHEADING"],
		["Written and developed together by a6h1 & masuwuked", "NORMAL"],
		["", "NORMAL"],
		["Level & Map Design", "SUBHEADING"],
		["Both developers contributed equally to shaping the world", "NORMAL"],
		["", "NORMAL"],
		["Shaders", "SUBHEADING"],
		["a6h1 — enhancing graphics with atmospheric visual effects", "NORMAL"],
		["CRT effect code — immersive retro screen distortion", "NORMAL"],
		["Glitch effect code — dynamic visual interference & noise", "NORMAL"],
		["", "NORMAL"],
		["Scene Transitions", "SUBHEADING"],
		["Main Scene Transitions: masuwuked", "NORMAL"],
		["Smooth Transition Effects: a6h1", "NORMAL"],
		["", "NORMAL"],
		["Dialogue Writing", "SUBHEADING"],
		["a6h1 — crafting the conversations and narrative tone", "NORMAL"],
		["", "NORMAL"],
		["Gameplay Systems", "SUBHEADING"],
		["Item Pickup and achievements System: masuwuked", "NORMAL"],
		["Collision Handling: a6h1", "NORMAL"],
		["Platformer Scene: masuwuked", "NORMAL"],
		["Dialogue System: a6h1", "NORMAL"],
		["", "NORMAL"],
		["User Interface", "SUBHEADING"],
		["masuwuked — designing menus and interactive elements", "NORMAL"],
		["", "NORMAL"],
		["Audio", "SUBHEADING"],
		["Music & SFX Integration: a6h1 & masuwuked", "NORMAL"],
		["", "NORMAL"],
		["References & Asset Credits", "HEADING"],
		["William Afton — Five Nights at Freddy’s", "NORMAL"],
		["FNaF OST — Five Nights at Freddy’s", "NORMAL"],
		["Foxy Jumpscare — Five Nights at Freddy’s", "NORMAL"],
		["Interior Assets — itch.io & OpenGameArt", "NORMAL"],
		["SFX & Music — Bytebeat Board from Dollchan, Pixabay and SFXR", "NORMAL"],
		["", "NORMAL"],
		["Special Thanks", "HEADING"],
		["The online game dev community, for tutorials and free resources", "NORMAL"],
		["Coffee, for keeping us alive during 3 AM debugging sessions", "NORMAL"],
		["And to you, the player — for making this journey worth it", "NORMAL"],
		["", "NORMAL"],
		["", "NORMAL"],
		["We started this as beginners.\nWe ended it as creators.\nThank you for playing.", "NORMAL"]
	]

	for line in credits_text:
		var label = Label.new()
		label.text = line[0]
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.add_theme_constant_override("line_spacing", extra_spacing)

		if custom_font:
			label.add_theme_font_override("font", custom_font)

		match line[1]:
			"TITLE":
				label.add_theme_font_size_override("font_size", title_size)
				label.add_theme_color_override("font_color", title_color)
			"SUBTITLE":
				label.add_theme_font_size_override("font_size", subtitle_size)
				label.add_theme_color_override("font_color", subtitle_color)
			"HEADING":
				label.add_theme_font_size_override("font_size", heading_size)
				label.add_theme_color_override("font_color", heading_color)
			"SUBHEADING":
				label.add_theme_font_size_override("font_size", subheading_size)
				label.add_theme_color_override("font_color", subheading_color)
			"NORMAL":
				label.add_theme_font_size_override("font_size", normal_size)
				label.add_theme_color_override("font_color", normal_color)

		credits.add_child(label)

func _start_scroll():
	started = true
	audio.play()

func _process(delta):
	if started:
		credits.position.y -= scroll_speed * delta
		if credits.position.y + credits.size.y < 0:
			started = false
			_fade_out()

func _fade_out():
	var t = create_tween()
	ani.play("fade_out")
	t.tween_property(fader, "modulate:a", 1.0, 1.5)
	t.tween_callback(_end_credits)

func _end_credits():
	get_tree().change_scene_to_file(end_scene_path)
	#get_tree().quit()
