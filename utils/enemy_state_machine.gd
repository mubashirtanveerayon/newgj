extends StateMachine
class_name EnemyStateMachine
@export var movement_component:MovementComponent
@export var health_system:HealthSystem
var player:Character
func _ready():
	player = get_tree().get_first_node_in_group("player")
	if player != null:
		player.tree_exiting.connect(on_player_dead)
	#if health_system != null:
		#health_system.body_entered.connect(on_health_system_body_entered)
		#health_system.body_exited.connect(on_health_system_body_exited)
	
	for state in get_children(false):
		if state is  EnemyState:
			state.player = player
			state.movement_component = movement_component
	super._ready()

func on_player_dead():
	current_state.exit()

func get_spawners()->Array[Spawner]:
	var array:Array[Spawner]=[]
	for child in get_children(false):
		if child is EnemyState:
			var spawner:Spawner=child.get_spawner()
			if spawner!=null:
				array.append(spawner)
	return array

#func on_health_system_body_entered(body):
	#if body.is_in_group("player"):
		#on_player_body_entered(body)
#
#func on_health_system_body_exited(body):
	#if body.is_in_group("player"):
		#on_player_body_exited(body)
#
#func on_player_body_entered(_player:Character):
	#pass
#
#func on_player_body_exited(_player:Character):
	#pass
