extends Card

func _init() -> void:
	name_to_show="Fire rate nerf"
	description = "-10% fire rate"
	icon = load("res://assets/cards/low_shoot_rate.png")
	
	
	
func on_acquire(context:Node2D):
	if not context is Character:
		return
	
	if context.is_in_group("enemies"):
		var state_machine :EnemyStateMachine
		for child in context.get_children(false):
			if child is EnemyStateMachine:
				state_machine=child
				break
		if state_machine:
			var spawners=state_machine.get_spawners()
			for spawner in spawners:
				spawner.spawn_interval -= spawner.spawn_interval * 0.1
	else:
		for child in context.get_children(false):
			if child is Shooter:
				child.cooldown_time += child.cooldown_time * 0.1
				break
