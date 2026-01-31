extends State
class_name EnemyState

var player:Character
var movement_component:MovementComponent


func get_spawner()->Spawner:
	for child in get_children(false):
		if child is Spawner:
			return child
	return null
