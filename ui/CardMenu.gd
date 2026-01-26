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
		var btn = Button.new()
		btn.text = "Pick"
		btn.custom_minimum_size.y = 40 
		column.add_child(btn)
		
		btn.pressed.connect(_on_card_selected.bind(script_pair["card"]))
		
		temp_card1.queue_free()
		temp_card2.queue_free()

func _on_card_selected(card_script):
	if player:
		player.add_card(card_script[0].new())
	
	Global.add_card(card_script[1].new())
	
	# Resume Logic
	get_tree().paused = false
	queue_free()
