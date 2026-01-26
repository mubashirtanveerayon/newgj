extends Control


func show_card_menu():
	get_tree().paused=true
	
	show()
	
	var card_scripts = generate_card_pairs(3)
	for script_dict in card_scripts:
		var cards:Array[Script] = script_dict["card"]
		
	
	
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
