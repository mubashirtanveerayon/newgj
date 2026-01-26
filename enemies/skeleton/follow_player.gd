extends EnemyState

func enter():
	super.enter()
	$"../../AnimatedSprite2D".play("run")
	movement_component.enabled=true
func _physics_process(delta: float) -> void:

	if player:
		var d = player.global_position - global_position + Vector2.from_angle(randf() * TAU)*5
		movement_component.direction = d.normalized()
		
