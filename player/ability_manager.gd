extends Node2D
signal ability_cooldown_time_changed
signal ability_used(msg)

var shockwave_scene = preload("res://player_ultimate/Shockwave.tscn")
@export var ability_cooldown_time:float=2:
	set(value):
		ability_cooldown_time=value
		ability_cooldown_time_changed.emit()

func _ready() -> void:
	ability_cooldown_time_changed.connect(on_ability_cooldown_time_changed)

func _process(delta: float) -> void:
	if Input.is_action_pressed("alt_power") and $Timer.is_stopped():
		try_use_shockwave()


func on_ability_cooldown_time_changed():
	$Timer.wait_time=ability_cooldown_time

func try_use_shockwave():
	if Global.points >= Global.points_req_for_alt:
		Global.points -= Global.points_req_for_alt
		Global.points_req_for_alt += 100
		var sw = shockwave_scene.instantiate()
		sw.global_position = global_position 
		get_tree().get_first_node_in_group("world").add_child(sw)
		$Timer.start()
		$"../Camera2D".shake(1.5,1)
		$AudioStreamPlayer2D.play()
		ability_used.emit("Shockwave cost increased to "+str(Global.points_req_for_alt))
