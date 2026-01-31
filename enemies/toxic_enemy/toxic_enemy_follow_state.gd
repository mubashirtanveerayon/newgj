extends "res://utils/misc/enemy_follow_state.gd"


func enter():
	
	$"../../AnimatedSprite2D".play("run")
	super.enter()
