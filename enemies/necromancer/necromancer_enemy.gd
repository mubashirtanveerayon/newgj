extends Enemy


func _ready():
	super._ready()
	$EnemyStateMachine/Shoot/Spawner.deck=deck


func _on_character_took_damage(damage_dealt: Variant) -> void:
	super._on_character_took_damage(damage_dealt)
	if not $AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()
func _process(delta: float) -> void:
	if velocity.length_squared()>100:
		$AnimatedSprite2D.flip_h = velocity.x<0
