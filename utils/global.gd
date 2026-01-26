signal point_changed(delta:int)

var points:int=0:
	set(value):
		var delta:int=value-points
		
		points=value
		if delta != 0:
			point_changed.emit(delta)
