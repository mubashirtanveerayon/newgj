extends Enemy


func destroy():
	$AnimatedSprite2D.hide()
	BloodAnimation.play(4,global_position)
	super.destroy()
func _process(delta: float) -> void:
	if velocity.length_squared()>100:
		$AnimatedSprite2D.flip_h = velocity.x<0

	
