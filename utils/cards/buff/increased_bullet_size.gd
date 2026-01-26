extends Card

func _init() -> void:
	name_to_show="Increased bullet size"
	description="Bullet size multiplied by 1.5"
	icon = load("res://assets/cards/big_bullet.png")

func on_attack(context:Node2D):
	if not context.is_in_group("projectile"):
		return
	context.scale *= 1.5
	return [context]
