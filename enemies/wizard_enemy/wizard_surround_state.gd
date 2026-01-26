extends "res://utils/misc/surround_state.gd"


func enter():
	$"../../AnimatedSprite2D".play("run")
	super.enter()
