extends Area2D
class_name HealthSystem
@export var can_take_damage:bool:
	set(value):
		can_take_damage=value
		monitorable=can_take_damage

@export var can_deal_damage:bool:
	set(value):
		can_deal_damage=value
		monitoring=can_deal_damage
		
var enabled:=true
signal took_damage(damage_dealt)
signal health_increased(buff_amount)
signal health_changed
signal stats_changed(prev_stats: Dictionary[String, int],new_stats: Dictionary[String, int])
signal dead
@export var stats: Dictionary[String, int] = {
	"damage": 0,
	"max_health": 0
}:
	set(value):
		var prev_stats=stats.duplicate(true)
		stats = value
		stats_changed.emit(prev_stats,stats)
var health:int=0:
	set(value):
		var new_health:Variant=min(max(0,value),stats["max_health"])
		var prev_health:=health
		health = new_health
		if prev_health>new_health:
			took_damage.emit(new_health-prev_health)
			health_changed.emit()
		elif prev_health < new_health:
			health_increased.emit(new_health-prev_health)
			health_changed.emit()


var is_dead:bool=false
#var collision_shape

func disable():
	enabled = false
	for child in get_children(false):
		if child is CollisionShape2D:
			child.set_deferred("disabled",true)

func enable():
	enabled=true
	for child in get_children(false):
		if child is CollisionShape2D:
			child.set_deferred("disabled",false)

func take_damage(damage_to_be_dealt:int):
	if not enabled:
		return
	
	var new_health:int=max(0,health-damage_to_be_dealt)
	
	health = new_health
	if health == 0 and not is_dead:
		dead.emit()
		is_dead=true


func _ready():
	monitoring = can_deal_damage
	monitorable = can_take_damage
	
	#if not monitorable:
		#collision_layer=0
	health = stats["max_health"]
	area_entered.connect(on_area_entered)
	is_dead = health == 0


func toggle():
	if enabled:
		disable()
	else:
		enable()

func on_area_entered(area):
	if not enabled:
		return
	if area is HealthSystem:
		area.take_damage(stats["damage"])
