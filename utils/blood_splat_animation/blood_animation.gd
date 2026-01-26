extends Node2D


@onready var blood_splat_animation:PackedScene = preload("res://utils/blood_splat_animation/blood_splat_animation.tscn")

func play(level:int,pos:Vector2):
	var animation = blood_splat_animation.instantiate()
	animation.global_position = pos
	animation.animation_finished.connect(animation.queue_free)
	animation.animation=animation.sprite_frames.get_animation_names()[level]
	get_tree().get_first_node_in_group("world").add_child(animation)
	animation.play()
