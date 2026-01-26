extends Control




func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main/main.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_control_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/controlsmenu.tscn")


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/creditsmenu.tscn")
