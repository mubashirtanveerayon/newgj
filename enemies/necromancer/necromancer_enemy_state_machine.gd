extends EnemyStateMachine

func _process(delta: float) -> void:
	print(current_state.name)


func _on_player_detector_area_entered(area: Area2D) -> void:
	change_to($Shoot)


func _on_player_detector_area_exited(area: Area2D) -> void:
	change_to($SurroundState)
