extends State

@export var time_in_minutes:float = 1
@export var wave_label:Label

@export var enemy_spawners:Array[Spawner]
@export var wave_number:int
func enter():
	super.enter()
	
	var label := Label.new()
	label.theme=load("res://assets/ui_theme.tres")
	label.text = "Wave " + str(wave_number)
	label.global_position = individual.global_position
	label.global_position.x -= label.size.x/2
	add_child(label)

	if wave_label != null:
		wave_label.text = "Wave " + str(wave_number)
		wave_label.show()
	var tween := get_tree().create_tween()
	tween.tween_property(label,"self_modulate:a",0,2)
	tween.parallel().tween_property(label,"scale",Vector2(2,2),2)
	tween.finished.connect(label.queue_free)
	for spawner in enemy_spawners:
		spawner.enabled=true
	await get_tree().create_timer(time_in_minutes  * 60).timeout
	finished.emit()


func exit():
	super.exit()
	if wave_label != null:
		wave_label.hide()
