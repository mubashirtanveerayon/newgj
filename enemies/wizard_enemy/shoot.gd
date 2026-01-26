extends EnemyState


func enter():
	movement_component.enabled=false
	$"../../AnimatedSprite2D".play("idle")
	$Spawner.enabled = true
	super.enter()


func exit():
	$Spawner.enabled = false
	super.exit()
