extends Node

signal point_changed(delta:int)
signal point_reached_ability_cost

var points_req_for_alt=200

var points:int=0:
	set(value):
		var delta:int=value-points
		if value>=points_req_for_alt and points<=points_req_for_alt:
			point_reached_ability_cost.emit()
		points=value
		if delta != 0:
			point_changed.emit(delta)
		


var deck:Array[Card]

func add_card(card:Card):
	deck.append(card)
