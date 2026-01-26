extends MovementComponent

func _physics_process(delta):
	direction = Input.get_vector("move_left","move_right","move_up","move_down")
	super._physics_process(delta)
