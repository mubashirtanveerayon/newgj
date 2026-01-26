extends "res://utils/misc/surround_state.gd"


func enter():
	super.enter()
	$"../../AnimatedSprite2D".play("run")
	$Spawner.enabled=true

func exit():
	super.exit()
	$Spawner.enabled=false
