extends VideoStreamPlayer

func _ready():
	size = get_viewport_rect().size  # Fit to window size
	connect("resized", Callable(self, "_on_window_resized"))

func _on_window_resized():
	size = get_viewport_rect().size
