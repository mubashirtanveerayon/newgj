extends Control

func _ready() -> void:
	$VBoxContainer/Label.text = "Game over!\nSouls collected: "+str(Global.points)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/mainmenu.tscn")
