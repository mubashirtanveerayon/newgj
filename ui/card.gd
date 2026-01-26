extends TextureRect

@onready var title_label = $Label
@onready var desc_label = $Label2
@onready var icon_rect = $icon


func set_content(title_text: String, desc_text: String, icon_texture = null):
	title_label.text = title_text
	desc_label.text = desc_text
	
	if icon_texture:
		icon_rect.texture = icon_texture
	
	# Future: if image_path != "", load(image_path)
