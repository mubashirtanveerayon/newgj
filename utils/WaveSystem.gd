extends StateMachine


class_name WaveSystem

@export var waves:Array[State]



var wave_index:int=0

func _ready():
	if not waves.is_empty():
		initial_state = waves[0]
	super._ready()

func on_state_execution_finished():
	wave_index += 1
	if wave_index >= waves.size():
		return
	change_to(waves[wave_index])
