extends Character


func _ready():
	super._ready()
	$AnimatedSprite2D.play("idle")
	$Shooter.deck = deck

func _process(delta: float) -> void:
	if velocity.length_squared()==0 :
		if $AnimatedSprite2D.animation == "run":
			$AnimatedSprite2D.play("idle")
	else:
		if $AnimatedSprite2D.animation == "idle":
			$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = velocity.x < 0
