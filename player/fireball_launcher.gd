extends Shooter


func _on_shot(shot_bullets: Array) -> void:
	if $AudioStreamPlayer2D.playing:
		return
	$AudioStreamPlayer2D.play()
