extends EnemyState


signal target_location_ping_time_changed
signal avoid_player_changed
@export var avoid_player:bool=false:
	set(value):
		avoid_player=value
		avoid_player_changed.emit()


@export var target_location_ping_time:float = 1:
	set(value):
		target_location_ping_time=value
		target_location_ping_time_changed.emit()

var target_position:Vector2

var move_directions :Array[Vector2]= [Vector2.LEFT,Vector2(-1,-1).normalized(),Vector2.UP,Vector2(1,-1).normalized(),Vector2.RIGHT,Vector2(1,1).normalized(),Vector2.DOWN,Vector2(-1,1).normalized()]

func _ready():
	super._ready()
	target_location_ping_time_changed.connect(on_target_location_ping_time_changed)
	avoid_player_changed.connect(set_obstacle_ray_collision_mask)
	set_obstacle_ray_collision_mask()

	$Timer.wait_time = target_location_ping_time
	$Timer.start()
	



func set_obstacle_ray_collision_mask():
	for child in $ObstacleRayCast.get_children():
		if child is RayCast2D:
			child.set_collision_mask_value(1,avoid_player)

func on_target_location_ping_time_changed():
	$Timer.wait_time = target_location_ping_time

func enter():
	if movement_component == null or player == null:
		#finished.emit()
		return
	movement_component.enabled=true

	$ObstacleRayCast.enabled=true
	super.enter()



func _physics_process(delta):
	if player == null or movement_component == null:
		return
	

	var interests:Array[float]
	
	for direction in move_directions:
		interests.append(direction.dot(global_position.direction_to(target_position)))
	
	var context_map:Array[float]
	
	for i in range(interests.size()):
		context_map.append(interests[i] - $ObstacleRayCast.danger_array[i])
	
	movement_component.direction = move_directions[context_map.find(context_map.max())]



func exit():
	$ObstacleRayCast.enabled=false
	super.exit()


func _on_timer_timeout():
	if enabled and player != null:
		target_position = player.global_position 

# 
