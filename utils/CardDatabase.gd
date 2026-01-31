extends Node

# Stores the SCRIPT resources (the blueprints)
var good_cards: Array[GDScript] = []
var bad_cards: Array[GDScript] = []

const GOOD_DIR := "res://utils/cards/buff"
const BAD_DIR  := "res://utils/cards/nerf"

func _ready() -> void:
	good_cards = _load_scripts_from_dir(GOOD_DIR)
	bad_cards  = _load_scripts_from_dir(BAD_DIR)

	# Optional debug
	print("Loaded good cards:", good_cards.size())
	print("Loaded bad cards:", bad_cards.size())

func get_random_good_cards(count: int):
	var options = good_cards.duplicate()
	options.shuffle()
	return options.slice(0, min(count, options.size()))

func get_random_bad_cards(count: int):
	var options = bad_cards.duplicate()
	options.shuffle()
	return options.slice(0, min(count, options.size()))

# -------------------- helpers --------------------

func _load_scripts_from_dir(dir_path: String) -> Array[GDScript]:
	var result: Array[GDScript] = []

	var dir := DirAccess.open(dir_path)
	if dir == null:
		push_error("Failed to open directory: " + dir_path)
		return result

	dir.list_dir_begin()
	var file_name := dir.get_next()

	while file_name != "":
		# Skip hidden files/folders like .import, .gitkeep, etc.

		if file_name.begins_with(".") or file_name.begins_with("_"):
			file_name = dir.get_next()
			continue

		var full_path := dir_path.path_join(file_name)

		if not dir.current_is_dir() :
			#if file_name.ends_with(".gd"):
			var scr = load(full_path)
			if scr is GDScript:
				result.append(scr)
			else:
				push_warning("Loaded resource was not a GDScript: " + full_path)

		file_name = dir.get_next()

	dir.list_dir_end()
	return result
