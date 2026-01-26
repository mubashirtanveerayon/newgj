extends EnemyState


signal attack_interval_changed
@export var attack_interval:float=1:
	set(value):
		attack_interval=value
		attack_interval_changed.emit()
func _ready():
	super._ready()
	attack_interval_changed.connect(on_attact_interval_changed)
	
func on_attact_interval_changed():
	$Timer.wait_time = attack_interval
func enter():
	super.enter()
	movement_component.enabled=false
	$"../../AnimatedSprite2D".play("idle")
	$Timer.wait_time = attack_interval
	$"../../Sword".act()
	$Timer.start()

func _on_sword_finished() -> void:
	$Timer.start()

func _physics_process(delta: float) -> void:
	if player:
		if player.global_position.x < global_position.x :
			if $"../../Sword".scale.x >0:
				$"../../Sword".scale.x = -1
		else:
			if $"../../Sword".scale.x <0:
				$"../../Sword".scale.x = 1


func _on_timer_timeout() -> void:
	$"../../Sword".act()
