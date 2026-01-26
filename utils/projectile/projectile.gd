extends HealthSystem
@export var expire_time:float=2

var card_applied:Card=null

func _ready():
	can_take_damage=false
	can_deal_damage = true
	super._ready()
	body_entered.connect(on_body_entered)
	$ProjectileMovement.launch()
	$Timer.wait_time=expire_time
	$Timer.start()

func on_body_entered(body):
	
	take_damage(9999999999)

func on_area_entered(area):
	super.on_area_entered(area)
	take_damage(1)

func _on_timer_timeout():
	take_damage(9999999999)


func _on_dead() -> void:
	queue_free()
