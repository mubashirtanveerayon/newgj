extends CanvasLayer

func _ready():
	$HBoxContainer/Resume.pressed.connect(_on_resume_pressed)
	$HBoxContainer/exit.pressed.connect(_on_quit_pressed)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_resume_pressed()

func _on_resume_pressed():
	get_tree().paused = false
	queue_free()

func _on_quit_pressed():
	get_tree().quit()
