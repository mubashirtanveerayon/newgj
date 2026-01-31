extends Character


signal player_used_ability(message)

#@export var flash_duration:float=0.5
func _ready():
	super._ready()
	$AnimatedSprite2D.play("idle")
	$Shooter.deck = deck

func _process(_delta: float) -> void:

	if velocity.length_squared()==0 :
		if $AnimatedSprite2D.animation == "run":
			$AnimatedSprite2D.play("idle")
	else:
		if $AnimatedSprite2D.animation == "idle":
			$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = velocity.x < 0

func destroy():
	BloodAnimation.play(2,global_position)
	
	
	super.destroy()
	
func _on_character_took_damage(_damage_dealt: Variant) -> void:
	if not $AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()
	$HealthSystem.disable()
	$HitCooldownTimer.start()
	$AnimatedSprite2D.material.set_shader_parameter("enabled",true)
	#await get_tree().create_timer(flash_duration).timeout
	#$AnimatedSprite2D.material.set_shader_parameter("enabled",false)


func get_camera():
	return $Camera2D


func _on_hit_cooldown_timer_timeout() -> void:
	$HealthSystem.enable()
	$AnimatedSprite2D.material.set_shader_parameter("enabled",false)
	


func _on_ability_manager_ability_used(msg: String) -> void:
	player_used_ability.emit(msg)
