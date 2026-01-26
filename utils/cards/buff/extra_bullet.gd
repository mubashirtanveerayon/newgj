extends Card

func _init() -> void:
	name_to_show="Extra projectile"
	description = "+1 extra projectile"
	icon = load("res://assets/cards/shotgun.png")

func on_attack(context:Node2D):
	if not context.is_in_group("projectile"):
		return
	var bullet_2 = context.duplicate()
	
	context.rotation_degrees -= 5
	bullet_2.rotation_degrees += 5
	return [context, bullet_2]
