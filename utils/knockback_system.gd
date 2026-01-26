extends Area2D
class_name KnockBackSystem

var movement_component:MovementComponent

@export var can_receive_knock_back:bool=false:
	set(value):
		monitorable=value
		can_receive_knock_back=value

@export var can_apply_knock_back:bool=false:
	set(value):
		monitoring = value
		can_apply_knock_back=value
		


@export var knock_back_strength:float=12

@export var knock_back_receive_duration:float=0.2

@onready var parent = get_parent()

var being_knocked_back:bool=false
var knock_back_direction:Vector2
var knock_back:float

signal receiving_knock_back
signal knock_back_received

func _ready():
	monitoring = can_apply_knock_back
	monitorable = can_receive_knock_back
	
	if not monitorable:
		collision_layer=0
	
	area_entered.connect(on_area_entered)
	
	for sibling in get_parent().get_children(false):
		if sibling is MovementComponent:
			movement_component=sibling
			break
	

func _physics_process(delta):
	if being_knocked_back:
		if parent is Character:
			parent.velocity = knock_back_direction * knock_back
			parent.move_and_slide()
		else:
			parent.global_position += knock_back_direction * knock_back * delta

func receive_knock_back(direction:Vector2,strength:float):
	if being_knocked_back :
		return
	receiving_knock_back.emit()
	knock_back_direction = direction
	knock_back = strength
	
	var movement_state:bool
	if movement_component != null:
		movement_state = movement_component.enabled
		movement_component.enabled=false
	being_knocked_back=true
	await get_tree().create_timer(knock_back_receive_duration).timeout
	
	being_knocked_back=false
	
	if movement_component != null:
		movement_component.enabled=movement_state
	knock_back_received.emit()
	
func on_area_entered(area):
	if area is KnockBackSystem:
		area.receive_knock_back((area.global_position-global_position).normalized(),knock_back_strength)
