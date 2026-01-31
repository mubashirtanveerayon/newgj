extends CanvasLayer


# Adjust these paths based on the new Tree structure above!
@onready var card_container = $MainLayout/CardContainer 
@onready var background = $Background
@onready var player = get_tree().get_first_node_in_group("player")

const CARD_VISUAL_SCENE = preload("res://ui/card.tscn")

func _ready():
	get_tree().paused = true 
	
	# Ensure background covers everything
	background.anchor_right = 1.0
	background.anchor_bottom = 1.0
	background.color = Color(0, 0, 0, 0.7) # Semi-transparent black
	
	# Setup Card Container spacing
	card_container.add_theme_constant_override("separation", 50)
	
	# Clear old children
	for child in card_container.get_children():
		child.queue_free()
		
	display_cards()

func generate_card_pairs(pair_count: int) -> Array:
	var result_pairs = []
	for i in range(pair_count):
		var is_good_pair = randf() > 0.5 
		var pair = {}
		if is_good_pair:
			pair["card"] = CardDatabase.get_random_good_cards(2)
		else:
			pair["card"] = CardDatabase.get_random_bad_cards(2)
		pair["type"]=is_good_pair
		result_pairs.append(pair)
	
	return result_pairs





func display_cards():
	var card_scripts = generate_card_pairs(3)
	#print(card_scripts)
	
	for script_pair in card_scripts:
		# Create the Vertical Column for ONE choice pair
		var column = VBoxContainer.new()
		column.add_theme_constant_override("separation", 20) # Space between Top/Bottom card
		column.alignment = BoxContainer.ALIGNMENT_CENTER
		card_container.add_child(column)
		#print(script_pair["card"])
		var temp_card1 = script_pair["card"][0].new()
		var temp_card2 = script_pair["card"][1].new()
		
		# --- 1. Player Card (Top) ---
		var p_visual = CARD_VISUAL_SCENE.instantiate()
		column.add_child(p_visual)
		p_visual.set_content(temp_card1.name_to_show, temp_card1.description, temp_card1.icon) 
		p_visual.modulate = Color(0.8, 1, 0.8) 
		
		# --- 2. Enemy Card (Bottom) ---
		var e_visual = CARD_VISUAL_SCENE.instantiate()
		column.add_child(e_visual)
		e_visual.set_content(temp_card2.name_to_show, temp_card2.description, temp_card2.icon)
		e_visual.modulate = Color(1, 0.6, 0.6) 
		
		var is_good_pair=script_pair["type"]
		if is_good_pair:
			p_visual.modulate = Color(0.8, 1, 0.8) 
			e_visual.modulate = Color(0.8, 1, 0.8) 
		else:
			p_visual.modulate = Color(1, 0.6, 0.6) 
			e_visual.modulate = Color(1, 0.6, 0.6) 
		
		
		
		# --- 3. Pick Button ---
		var btn = get_button("Pick")
		column.add_child(btn)
		
		btn.pressed.connect(_on_card_selected.bind(script_pair["card"]))
		
		temp_card1.queue_free()
		temp_card2.queue_free()
func get_button(text):
	var btn:=Button.new()
	btn.text = text
	btn.custom_minimum_size = Vector2(0, 40)
	
	var normal := StyleBoxFlat.new()
	normal.bg_color = Color("#2e2e2e")
	normal.corner_radius_top_left = 6
	normal.corner_radius_top_right = 6
	normal.corner_radius_bottom_left = 6
	normal.corner_radius_bottom_right = 6
	normal.content_margin_left = 12
	normal.content_margin_right = 12

	# Hover
	var hover := normal.duplicate()
	hover.bg_color = Color("#3f3f3f")  # lighter on hover

	# Pressed
	var pressed := normal.duplicate()
	pressed.bg_color = Color("#1f1f1f")  # darker when pressed

	btn.add_theme_stylebox_override("normal", normal)
	btn.add_theme_stylebox_override("hover", hover)
	btn.add_theme_stylebox_override("pressed", pressed)

	btn.add_theme_color_override("font_color", Color.WHITE)
	btn.add_theme_font_size_override("font_size", 16)

	btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	return btn

func _on_card_selected(card_script):
	var player_list = get_parent().get_node("UI/HUD/PlayerCards")
	var enemy_list = get_parent().get_node("UI/HUD/EnemyCards")
	
	if player:
		var card1=card_script[0].new()
		player.add_card(card1)
		add_to(player_list,card1)
		
	var card2=card_script[1].new()
	Global.add_card(card2)
	add_to(enemy_list, card2)
	
	# Resume Logic
	get_tree().paused = false
	queue_free()


func add_to(container: HBoxContainer, card: Card):
	if card.icon == null:
		return 
		
	# Create the Background (The Slot)
	var slot_bg = PanelContainer.new()
	slot_bg.custom_minimum_size = Vector2(40, 40) # Slightly bigger than the icon
	slot_bg.tooltip_text = "%s\n%s" % [card.name_to_show, card.description]
	
	# Style the Background (Dark Gray with Border)
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.1, 0.1, 0.1, 0.8) # Dark background
	style.border_width_left = 2
	style.border_width_top = 2
	style.border_width_right = 2
	style.border_width_bottom = 2
	style.border_color = Color(0.5, 0.5, 0.5) # Light gray border
	style.corner_radius_top_left = 4          # Rounded corners
	style.corner_radius_top_right = 4
	style.corner_radius_bottom_right = 4
	style.corner_radius_bottom_left = 4
	
	slot_bg.add_theme_stylebox_override("panel", style)

	# Create the Icon
	var icon_display = TextureRect.new()
	icon_display.texture = card.icon
	icon_display.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon_display.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon_display.custom_minimum_size = Vector2(64, 64) 
	#icon_display.scale *= 2

	# Assemble
	slot_bg.add_child(icon_display)
	container.add_child(slot_bg)
