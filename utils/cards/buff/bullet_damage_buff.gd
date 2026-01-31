extends Card

func _init() -> void:
	name_to_show = "Damage increase"
	description = "+1 damage"
	icon = load("res://assets/cards/high_damage.png")

func on_attack(context:Node2D):
	if not context.is_in_group("projectile"):
		return
		
	context.stats["damage"] =context.stats["damage"]+ 1
	return context
