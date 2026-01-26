extends EnemyState
@export var distance_threshold:float=20


func enter():
	movement_component.enabled=true
	$"../../AnimatedSprite2D".play("run")
	super.enter()

func _physics_process(delta: float) -> void:
	if player:
		var d = player.global_position - global_position
		movement_component.direction = (d+Vector2.from_angle(randf() * TAU)*50).normalized()
	
		var distance = d.length()
		if distance<distance_threshold:
			state_machine.change_to($"../ReleaseToxin")
		$"../../AnimatedSprite2D".flip_h = individual.velocity.x<0
