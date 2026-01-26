extends Spawner
signal all_spawned

func spawn():
	super.spawn()
	if count >= max_count:
		enabled=false
		all_spawned.emit()
