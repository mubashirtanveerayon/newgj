extends Card


func _init() -> void:
	name_to_show = "Increased character size"
	description="Character scale multiplied by 1.5"
	icon=load("res://assets/cards/grow.png")

func on_acquire(context:Node2D):
	if not context is Character:
		return
	context.scale = clamp(context.scale * 1.5,Vector2(1,1),Vector2(2,2))
