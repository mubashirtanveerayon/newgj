extends CanvasLayer

@export var player :Character

var player_health_system:HealthSystem

var elapsed_seconds:int=0

var current_wave_duration:float

var is_final_wave:bool=false

func _ready():
	
	Global.point_changed.connect(on_point_changed)
	Global.point_reached_ability_cost.connect(on_point_reached_ability_cost)
	if player != null:
		player.tree_exiting.connect(on_player_dead)
		player_health_system = player.find_child("HealthSystem",false)
		if player_health_system != null:
			player_health_system.health_changed.connect(update_ui)
			$HUD/HeartContainer.columns = player_health_system.stats["max_health"]
	
	update_ui()
func on_point_reached_ability_cost():
	%Label.self_modulate=Color(1,1,1,1)
	%Label.text="Press 'E' to use special ability!"
	get_tree().create_tween().tween_property(%Label,"self_modulate:a",0.0,4)

func update_wave_duration(duration:float,final_wave:bool):
	current_wave_duration=duration
	if not is_final_wave and final_wave:
		%Label.self_modulate=Color(1,1,1,1)
		%Label.text="Survive as long as you can!"
		get_tree().create_tween().tween_property(%Label,"self_modulate:a",0.0,4)
	
	if not final_wave:
		elapsed_seconds=0
	is_final_wave=final_wave
	

func on_point_changed(delta):
	%PointLabel.text="Souls:%02d"%Global.points
	%PointChangeLabel.text = "%+d" % delta
	if delta>0:
		%PointChangeLabel.self_modulate.g=1
		%PointChangeLabel.self_modulate.r=0
		%PointChangeLabel.self_modulate.b=0
	else:
		%PointChangeLabel.self_modulate.g=0
		%PointChangeLabel.self_modulate.r=1
		%PointChangeLabel.self_modulate.b=0
	%PointChangeLabel.self_modulate.a=1
	get_tree().create_tween().tween_property(%PointChangeLabel,"self_modulate:a",0.0,0.75)

func update_ui():
	var current_wave = get_parent().current_state
	if is_final_wave:
		%TimeLabel.text="Survived: %02d:" % ((elapsed_seconds)/60) + "%02d"  % (elapsed_seconds%60)
		#Global.survived=elapsed_seconds
	else:
		%TimeLabel.text = "Next wave in: %02d:" % ((current_wave_duration - elapsed_seconds)/60) + "%02d"  % (int(current_wave_duration-elapsed_seconds)%60)
	if player_health_system == null:
		return
	for child in $HUD/HeartContainer.get_children(false):
		$HUD/HeartContainer.remove_child(child)
	for i in range(player_health_system.stats["max_health"]-player_health_system.health,player_health_system.stats["max_health"]):
		var texture_rect := TextureRect.new()
		texture_rect.texture = load("res://assets/frames/ui_heart_full.png")
		$HUD/HeartContainer.add_child(texture_rect)


func on_player_dead():
	$HUD/Timer.one_shot=true
	$HUD/Timer.stop()

func _on_timer_timeout():
	elapsed_seconds += 1
	update_ui()


func _on_player_player_used_ability(message: Variant) -> void:
	%Label.self_modulate=Color(1,0,0,1)
	
	%Label.text=message
	get_tree().create_tween().tween_property(%Label,"self_modulate:a",0.0,4)
