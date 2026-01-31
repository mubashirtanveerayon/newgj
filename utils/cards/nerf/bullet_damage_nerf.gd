extends Card
func _init() -> void:
	name_to_show = "Damage Decrease"
	description = "-1 damage"
	icon=load("res://assets/cards/damage_nerf.png")

func on_attack(context:Node2D):
	if not context.is_in_group("projectile"):
		return
		
	context.stats["damage"] = max(1,context.stats["damage"]-1)
	return context
