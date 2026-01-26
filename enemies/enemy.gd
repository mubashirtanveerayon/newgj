extends Character

class_name Enemy



func _ready():
	super._ready()
	
	for card in Global.deck:
		card.on_acquire(self)
		deck.append(card)
	
