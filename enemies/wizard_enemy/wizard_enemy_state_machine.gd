extends EnemyStateMachine




func _on_player_detector_area_entered(area: Area2D) -> void:
	if area.get_parent() == player:
		change_to($Shoot)


func _on_player_detector_area_exited(area: Area2D) -> void:
	if area.get_parent() == player:
		change_to($SurroundState)
