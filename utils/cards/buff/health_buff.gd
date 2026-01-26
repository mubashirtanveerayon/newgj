extends Card

func _init() -> void:
	name_to_show = "Health buff"
	description = "+2 health"
	icon = load("res://assets/cards/health_buff.png")


func on_acquire(context:Node2D):
	var health_system = context.get_node("HealthSystem") as HealthSystem
	if health_system:
		health_system.health += 2
