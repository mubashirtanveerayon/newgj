@tool
extends Control

# Exported variables show up in the Editor Inspector
@export var ability_icon: Texture2D:
	set(value):
		ability_icon = value
		if has_node("margin/Icon"):
			$margin/Icon.texture = value

@export var trigger_key: String = "E":
	set(value):
		trigger_key = value
		if has_node("KeyLabel"):
			$KeyLabel.text = value.to_upper()

@export var background_texture: Texture2D:
	set(value):
		background_texture = value
		if has_node("Background"):
			$Background.texture = value

# This ensures it updates when the game starts, too
func _ready():
	# Force update visual state
	if has_node("margin/Icon"): $margin/Icon.texture = ability_icon
	if has_node("KeyLabel"): $KeyLabel.text = trigger_key.to_upper()
	if has_node("Background") and background_texture: $Background.texture = background_texture
