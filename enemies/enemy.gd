extends Character

class_name Enemy

var animated_sprite:AnimatedSprite2D
@export var flash_duration:float=0.5
func _ready():
	super._ready()
	
	for card in Global.deck:
		card.on_acquire(self)
		deck.append(card)
	for child in get_children(false):
		if child is AnimatedSprite2D:
			animated_sprite=child
			break
	
func _on_character_took_damage(damage_dealt: Variant) -> void:
	if animated_sprite:
		
		animated_sprite.material.set_shader_parameter("enabled",true)
		await get_tree().create_timer(flash_duration).timeout
		animated_sprite.material.set_shader_parameter("enabled",false)
	
