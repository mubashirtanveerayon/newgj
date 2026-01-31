extends Spawner

var deck:Array[Card]

func spawn():
	if count >= max_count:
		return
	var world = get_tree().get_first_node_in_group("world")
	if world == null or object_scene == null:
		return
	
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	var spawn_marker = spawn_locations.pick_random()
	if spawn_marker == null:
		return
	
	var object = object_scene.instantiate()
	object.global_position = spawn_marker.global_position
	object.global_rotation = ((player.global_position - spawn_marker.global_position) as Vector2).angle()
	
	var bullets = apply_card_effects(object)
	for b in bullets:
	
		b.tree_exiting.connect(on_object_tree_exiting)
		world.add_child(b)
		spawned.emit(b)
		count += 1

func apply_card_effects(bullet)->Array:
	var current_projectiles = [bullet]
	
	for card in deck:
		var next_step_projectiles = []
		for proj in current_projectiles:
			var result = card.on_attack(proj)
			if result is Array:
				next_step_projectiles.append_array(result)
			else:
				next_step_projectiles.append(result)
		current_projectiles = next_step_projectiles
		
	return current_projectiles
