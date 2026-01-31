extends Card


func _init() -> void:
	name_to_show = "Health nerf"
	description = "-1 health"
	icon=load("res://assets/cards/low_health.png")


func on_acquire(context:Node2D):
	var health_system = context.get_node("HealthSystem") as HealthSystem
	if health_system:
		health_system.health -= 1
