extends "res://utils/misc/enemy_follow_state.gd"


@export var target_surround_radius:float=50



func _on_timer_timeout():
	if enabled and player != null:
		target_position = player.global_position + Vector2(randf_range(-1,1),randf_range(-1,1)).normalized() * target_surround_radius
