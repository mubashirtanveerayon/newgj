extends Card

func _init() -> void:
	name_to_show="Fire rate buff"
	description = "+10% fire rate"
	icon = load("res://assets/cards/high_fire_rate.png")
	
func on_acquire(context:Node2D):
	if not context is Character:
		return
	
	if context.is_in_group("enemies"):
		for child in context.get_children(false):
			if child is Spawner:
				child.spawn_interval -= child.spawn_interval * 0.1
				break
	elif context.is_in_group("player"):
		for child in context.get_children(false):
			if child is Shooter:
				child.cooldown_time -= child.cooldown_time * 0.1
				break
