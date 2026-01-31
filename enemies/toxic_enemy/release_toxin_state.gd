extends EnemyState

signal toxin_release_time_changed
@export var toxin_release_time:float =1:
	set(value):
		toxin_release_time=value
		toxin_release_time_changed.emit()

func _ready():
	super._ready()
	toxin_release_time_changed.connect(on_toxin_release_time_changed)

func on_toxin_release_time_changed():
	$Timer.wait_time=toxin_release_time



func enter():
	movement_component.enabled=false
	$"../../AnimatedSprite2D".play("idle")
	super.enter()
	$CPUParticles2D.show()
	$HealthSystem.enable()
	$Timer.start()


func _on_timer_timeout() -> void:
	
	if enabled:
		for area in $HealthSystem.get_overlapping_areas():
			if area is HealthSystem:
				$HealthSystem.on_area_entered(area)
		$Timer.start()
		
  
func exit():
	$HealthSystem.disable()
	$CPUParticles2D.hide()
	super.exit()
