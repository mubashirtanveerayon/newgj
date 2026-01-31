extends Sprite2D

func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)

func _physics_process(delta):
	global_position = get_global_mouse_position()
