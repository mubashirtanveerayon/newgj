extends WaveSystem
@export var cardmenu_scene:PackedScene
const PAUSE_MENU_SCENE = preload("res://ui/pause_menu.tscn")

func on_state_execution_finished():
	
	var cardmenu = cardmenu_scene.instantiate()
	
	add_child(cardmenu)
	super.on_state_execution_finished()

func _ready():
	super._ready()
	var camera = $Player.get_camera()
	
	camera.limit_left = $Boundary/TopLeft.global_position.x
	camera.limit_top =$Boundary/TopLeft.global_position.y
	camera.limit_right = $Boundary/BottomRight.global_position.x
	camera.limit_bottom = $Boundary/BottomRight.global_position.y
	



func _input(event):
	# pause (esc)
	if event.is_action_pressed("ui_cancel"):
		pause_game()


func pause_game():
	if get_tree().paused:
		return

	get_tree().paused = true
	var menu = PAUSE_MENU_SCENE.instantiate()
	add_child(menu)


func _on_player_destroyed(point: Variant, pos: Variant) -> void:
	#await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://ui/gameoverscreen.tscn")
