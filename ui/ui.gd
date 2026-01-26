extends CanvasLayer

@export var player :Character

var player_health_system:HealthSystem
signal minute_passed

var elapsed_minutes:int=0
var elapsed_seconds:int=0:
	set(value):
		elapsed_seconds = value
		if elapsed_seconds % 60 == 0 and elapsed_seconds > 0:
			elapsed_minutes += 1
			minute_passed.emit()

func _ready():
	
	Global.point_changed.connect(on_point_changed)
	if player != null:
		player.tree_exiting.connect(on_player_dead)
		player_health_system = player.find_child("HealthSystem",false)
		if player_health_system != null:
			player_health_system.health_changed.connect(update_ui)
			$HUD/HeartContainer.columns = player_health_system.stats["max_health"]
	
	update_ui()

func on_point_changed(delta):
	%PointLabel.text="Souls:%02d"%Global.points
 
func update_ui():
	%TimeLabel.text = "%02d:" % (elapsed_seconds/60) + "%02d"  % (elapsed_seconds%60)
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
