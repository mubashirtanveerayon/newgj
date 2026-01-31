extends Handheld


func act():
	$AnimationPlayer.play("swing")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	finished.emit()
