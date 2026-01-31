extends Handheld
class_name Shooter

signal cooldown_time_changed
signal shot(shot_bullets:Array)


var shots:int=0
var muzzle_marker:Marker2D

@export var bullet_scene:PackedScene

var deck:Array[Card]

@export var cooldown_time:float=0.5:
	set(value):
		cooldown_time=value
		cooldown_time_changed.emit()


func _ready():
	super._ready()
	shot.connect(on_bullet_shot)
	for child in $Pivot.get_children(false):
		if child is Marker2D:
			muzzle_marker = child
			break


	cooldown_time_changed.connect(on_cooldown_time_changed)
	$Timer.wait_time=cooldown_time
	
func _process(delta):
	$Pivot.look_at(get_global_mouse_position())
	#$Pivot/Sprite2D.flip_v = $Pivot.global_rotation<-PI/2 or $Pivot.global_rotation >PI/2
	if $Pivot.global_rotation<-PI/2 or $Pivot.global_rotation >PI/2:
		$Pivot.scale.y = -1
	else:
		$Pivot.scale.y = 1



func _physics_process(delta):
	if Input.is_action_pressed("primary_attack"):
		act()
	

func on_bullet_shot(bullet):
	$Timer.wait_time=cooldown_time
	$Timer.start()
	
func on_cooldown_time_changed():
	$Timer.wait_time=cooldown_time
	


func act():
	if enabled and $Timer.is_stopped() and bullet_scene != null and muzzle_marker != null:
		shoot()

func shoot():
	var world:=get_tree().get_first_node_in_group("world")
	if world == null:
		return
	active=true
	
	var bullet=bullet_scene.instantiate()
	
	bullet.global_position=muzzle_marker.global_position
	bullet.global_rotation = $Pivot.global_rotation
	
	var bullets = apply_card_effects(bullet)
	

	for b in bullets:
		world.add_child(b)
	
	active=false
	shot.emit(bullets)
	finished.emit()


func apply_card_effects(bullet)->Array:
	var current_projectiles = [bullet]
	
	for card in deck:
		var next_step_projectiles = []
		for proj in current_projectiles:
			var result = card.on_attack(proj)
			if result is Array:
				next_step_projectiles.append_array(result)
			else:
				next_step_projectiles.append(result)
		current_projectiles = next_step_projectiles
		
	return current_projectiles
