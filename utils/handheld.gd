extends Node2D
class_name Handheld


signal finished

var active:bool=false

@export var enabled:bool=false:
	set(value):
		enabled=value
		if enabled:
			show()
		else:
			hide()

func _ready():
	if enabled:
		show()
	else:
		hide()

func act():
	pass
