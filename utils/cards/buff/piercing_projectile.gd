extends Card

func _init() -> void:
	name_to_show="Piercing projectile"
	description="+1 pierce"
	icon=load("res://assets/cards/piercing.png")

func on_attack(context:Node2D):
	if not context is Projectile:
		return context
	context.stats["max_health"]+=1
	context.health=context.stats["max_health"]
	return context
