extends Node2D
class_name MovementComponent
signal stopped
signal enabled_changed
@export var enabled:bool=false:
	set(value):
		set_physics_process(value)
		set_process(value)
		enabled=value
		enabled_changed.emit()

@export var max_speed:float
@export var acceleration:float
@export var friction:float


var velocity:=Vector2.ZERO
var direction:=Vector2.ZERO:
	set(value):
		if enabled:
			direction=value


var is_stopped:bool=true

@onready var parent = get_parent()

func _physics_process(delta):
	if direction.length_squared()==0:
		velocity = velocity.move_toward(Vector2.ZERO,friction * delta)

		
	else:
		velocity = velocity.move_toward(direction * max_speed,acceleration * delta).limit_length(max_speed)
		is_stopped=false
	
	if parent is CharacterBody2D:
		parent.velocity = velocity
		parent.move_and_slide()
	else:
		parent.global_position += velocity * delta
	if velocity.length_squared() < 0.5 and not is_stopped:
		stopped.emit()
		is_stopped=true
