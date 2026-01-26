extends WaveSystem
@export var cardmenu_scene:PackedScene

func on_state_execution_finished():
	var cardmenu = cardmenu_scene.instantiate()
	add_child(cardmenu)
	super.on_state_execution_finished()




func _on_player_destroyed(point: Variant, pos: Variant) -> void:
	#await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://ui/gameoverscreen.tscn")
