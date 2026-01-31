extends EnemySpawner
signal all_dead

func spawn():
	super.spawn()
	if count >= max_count:
		enabled=false
func on_object_tree_exiting():
	super.on_object_tree_exiting()
	if count <= 0:
		all_dead.emit()
