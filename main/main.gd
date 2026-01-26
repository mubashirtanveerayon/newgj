extends WaveSystem
@export var cardmenu_scene:PackedScene

func on_state_execution_finished():
	var cardmenu = cardmenu_scene.instantiate()
	add_child(cardmenu)
	super.on_state_execution_finished()
