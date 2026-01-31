extends Spawner

class_name EnemySpawner


@onready var lightning_spawn_anim = preload("res://utils/LightningStrikeAnimation.tscn")

func _ready():
	super._ready()
	spawned.connect(on_enemy_spawned)

func on_enemy_spawned(enemy):
	if enemy is Enemy:
		var lightning_anim = lightning_spawn_anim.instantiate()
		lightning_anim.global_position = enemy.global_position
		get_tree().get_first_node_in_group("world").add_child(lightning_anim)
		lightning_anim.play("1")
		
		enemy.destroyed.connect(on_enemy_destroyed)
		
func on_enemy_destroyed(point,pos):
	Global.points += point
