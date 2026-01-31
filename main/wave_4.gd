extends "res://main/wave.gd"

func _on_necromancer_spawner_all_dead() -> void:
	for spawner in enemy_spawners:
		spawner.enabled=false
