extends HealthSystem
class_name Projectile
@export var expire_time:float=2

@onready var explosion_scene:PackedScene=null#preload("res://utils/explode.tscn")

var card_applied:Card=null

var explode:bool=false

func _ready():
	can_take_damage=false
	can_deal_damage = true
	super._ready()
	#body_entered.connect(on_body_entered)
	$ProjectileMovement.launch()
	$Timer.wait_time=expire_time
	$Timer.start()
	
	#TODO: remove this line
	explosion_scene=null

func on_area_entered(area):
	super.on_area_entered(area)
	
	if area is HealthSystem:
		take_damage(1)

func _on_timer_timeout():
	take_damage(9999999999)


func _on_dead() -> void:
	disable()
	#if explode and explosion_scene:
		#
		#var explode=explosion_scene.instantiate()
		#explode.global_position=global_position
		#get_tree().get_first_node_in_group("world").add_child(explode)
		#explode.explode()
		
	queue_free()
