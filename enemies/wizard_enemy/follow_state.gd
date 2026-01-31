extends EnemyState

func enter():
	movement_component.enabled=true
	$"../../AnimatedSprite2D".play("run")
	super.enter()

func _physics_process(delta: float) -> void:
	if player:
		var d = player.global_position - global_position
		movement_component.direction = (d+Vector2.from_angle(randf() * TAU)*30).normalized()
	

		$"../../AnimatedSprite2D".flip_h = individual.velocity.x<0
