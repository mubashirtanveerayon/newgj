extends Node2D
class_name Spawner
signal spawned(object)
signal spawn_interval_changed



@export var enabled:bool=true
@export var max_count:int=20

var count :int = 0


@export var spawn_interval:float=1:
	set(value):
		spawn_interval = value
		spawn_interval_changed.emit()
		
@export var object_scene:PackedScene
var spawn_locations:Array[Marker2D]

func _ready():
	spawn_interval_changed.connect(on_spawn_interval_changed)
	
	for child in get_children(false):
		if child is Marker2D:
			spawn_locations.append(child)
	
	$Timer.timeout.connect(_on_timer_timeout)
	$Timer.wait_time = spawn_interval
	$Timer.start()
	
	
func on_spawn_interval_changed():
	$Timer.wait_time = spawn_interval


func spawn():
	if count >= max_count:
		return
	var world = get_tree().get_first_node_in_group("world")
	if world == null or object_scene == null:
		return

	var spawn_marker = spawn_locations.pick_random()
	if spawn_marker == null:
		return
	var object = object_scene.instantiate()
	object.global_position = spawn_marker.global_position
	object.tree_exiting.connect(on_object_tree_exiting)
	world.add_child(object)
	spawned.emit(object)
	count += 1

func on_object_tree_exiting():
	count = max(0,count-1)

func _on_timer_timeout():
	if enabled and object_scene != null and not spawn_locations.is_empty():
		spawn()
