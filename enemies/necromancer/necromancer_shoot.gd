extends EnemyState


func enter():
	super.enter()
	$"../../AnimatedSprite2D".play("idle")
	$Spawner.enabled=true
	movement_component.enabled=false

func exit():
	super.exit()
	$Spawner.enabled=false
