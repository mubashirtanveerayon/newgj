extends Camera2D



@export var shake_strength:float=1
@export var default_shake_duration:float=0.1
@export var mouse_peek_dead_zone:int=800
@export var mouse_peek_speed:int = 100


var shaking:bool=false


var shake_duration:float
func on_gun_shot(_shot_bullets:Array):
	shake()



func _process(delta):
	

	var to_mouse:Vector2 = get_global_mouse_position() - global_position

	if to_mouse.length_squared() > mouse_peek_dead_zone:
		position = position.move_toward( Vector2.from_angle(to_mouse.angle()).normalized() * to_mouse.length()/2.0,delta*mouse_peek_speed)
	else:
		position = position.move_toward( Vector2.ZERO,delta*mouse_peek_speed)
	
	if shaking :
		shake_duration=max(0,shake_duration-delta)
		offset = Vector2(randf_range(-shake_strength,shake_strength),randf_range(-shake_strength,shake_strength))
		if shake_duration == 0:
			shaking=false
			offset=Vector2.ZERO

func shake(strength:float=shake_strength,duration:float=default_shake_duration):
	if shaking:
		return
	shake_strength=strength
	shake_duration=duration
	shaking=true
