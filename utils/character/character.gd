extends CharacterBody2D
class_name Character

@export  var death_point:int

signal destroyed(point,pos)

var deck:Array[Card]

var health_system:HealthSystem

var card_applied:Card=null



func _ready():
	
	for child in get_children(false):
		if child is HealthSystem:
			health_system = child
			break
	
	$HealthSystem.dead.connect(_on_health_system_dead)
	$HealthSystem.took_damage.connect(_on_character_took_damage)


func add_card(card:Card):
	deck.append(card)
	card.on_acquire(self)
func destroy():
	destroyed.emit(death_point,global_position)
	queue_free()

func _on_health_system_dead():
	destroy()

func _on_character_took_damage(damage_dealt: Variant) -> void:
	pass
	
