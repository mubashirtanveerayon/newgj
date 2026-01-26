extends MovementComponent

class_name ProjectileMovement

func launch():
	if parent == null:
		return
	enabled=true
	direction = Vector2.from_angle(parent.global_rotation)
