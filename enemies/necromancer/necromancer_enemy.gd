extends Enemy


func _ready():
	super._ready()
	$EnemyStateMachine/Shoot/Spawner.deck=deck
