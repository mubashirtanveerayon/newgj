extends EnemyStateMachine


func _on_player_detector_area_entered(area: Area2D) -> void:
	change_to($ReleaseToxin)


func _on_player_detector_area_exited(area: Area2D) -> void:
	change_to($FollowState)
	
