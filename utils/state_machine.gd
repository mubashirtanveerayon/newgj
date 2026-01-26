extends Node2D


class_name StateMachine
signal transition_completed
var states:Array[State]
var current_state:State

@export var initial_state:State
@export var individual:Node2D

func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			child.individual = individual
			child.finished.connect(on_state_execution_finished)

	if initial_state!=null:
		initial_state.enter()
		current_state = initial_state

func on_state_execution_finished():
	pass

func change_to(to:State):
	if to == current_state:
		return
	
	if current_state != null:
		current_state.exit()
	to.enter()
	
	current_state=to
	transition_completed.emit()
