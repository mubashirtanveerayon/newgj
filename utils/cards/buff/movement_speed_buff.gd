extends Card

func _init() -> void:
	name_to_show="Movement speed buff"
	description = "Movement speed increased by 30%"
	icon = load("res://assets/cards/fast_move.png")

func on_acquire(context:Node2D):
	if not context is Character:
		return
		
	for child in context.get_children(false):
		if child is MovementComponent:
			child.max_speed += child.max_speed * 0.3
			break
