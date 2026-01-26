extends Camera2D

@export var top_left_marker:Marker2D
@export var bottom_right_marker:Marker2D


func _ready() -> void:
	limit_left = top_left_marker.global_position.x
	limit_top = top_left_marker.global_position.y
	limit_right = bottom_right_marker.global_position.x
	limit_bottom = bottom_right_marker.global_position.y
