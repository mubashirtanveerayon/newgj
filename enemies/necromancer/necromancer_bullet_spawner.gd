extends "res://utils/enemy_projectile_spawner.gd"

@export var spawn_radius:float=64

func spawn():
	var world = get_tree().get_first_node_in_group("world")
	
	if world == null or object_scene == null or spawn_locations.is_empty():
		return

	var spawn_marker: Marker2D = spawn_locations.pick_random()
	if spawn_marker == null:
		return

	# --- ring settings ---
	var bullets :int= max(0, max_count-count)     # bullets per burst
	var radius := spawn_radius              # distance from marker (pixels)
	var start_angle := 0.0               # set to randf() * TAU for random rotation each burst

	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return

	for i in range(bullets):
		var angle := start_angle + (TAU * float(i) / float(bullets))
		var offset := Vector2(cos(angle), sin(angle)) * radius

		var obj := object_scene.instantiate()
		obj.global_position = spawn_marker.global_position + offset
		obj.global_rotation = angle

		# OPTIONAL: if your bullet script expects a direction/velocity,
		# set it here (adjust to your bullet API).
		# if obj.has_method("set_direction"):
		#     obj.set_direction(offset.normalized())
		# elif "direction" in obj:
		#     obj.direction = offset.normalized()
		var modified_bullets = apply_card_effects(obj)
		for b in modified_bullets:
	
			b.tree_exiting.connect(on_object_tree_exiting)
			world.add_child(b)
			spawned.emit(b)
			count += 1
		
