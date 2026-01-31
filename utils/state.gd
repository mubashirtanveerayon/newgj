extends Node2D
class_name State

var individual:Node2D

signal finished
var enabled:bool=false

var state_machine:StateMachine

func _ready():
	set_process(false)
	set_physics_process(false)
	state_machine = get_parent()

func enter():
	enabled=true
	set_process(true)
	set_physics_process(true)
	
func exit():
	enabled=false
	set_process(false)
	set_physics_process(false)
	#finished.emit()
