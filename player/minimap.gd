extends Area2D


@export var map_radius := 16


var enemies:Dictionary={}

func _physics_process(delta):
	
	for enemy in enemies:
		var to_enemy:Vector2=enemy.global_position - global_position
		var distance:float = to_enemy.length()
		var mapped_distance:float = remap(distance,0,$CollisionShape2D.shape.radius,0,map_radius)
		var position_vector:Vector2 = Vector2.from_angle(to_enemy.angle()).normalized() * mapped_distance

		enemies[enemy].position=%PlayerIndicator.position + position_vector
		

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		if not body.tree_exiting.is_connected(on_enemy_killed):
			body.tree_exiting.connect(on_enemy_killed)
		#var sprite := Sprite2D.new()
		#sprite.texture =%PlayerIndicator.texture
		#sprite.region_enabled=true
		#sprite.region_rect=%PlayerIndicator.region_rect
		#sprite.self_modulate=Color("#ff1212")
		var copy := %PlayerIndicator.duplicate(Node.DUPLICATE_USE_INSTANTIATION) as TextureRect
		copy.modulate = Color(1, 0, 0) # red tint
		enemies[body]=copy
		%Minimap.add_child(copy)

func on_enemy_killed():
	for sprite in %Minimap.get_children(false):
		if sprite is TextureRect and sprite != %PlayerIndicator and sprite != %Frame:
			if enemies.find_key(sprite) == null:
				
				sprite.queue_free()


func _on_body_exited(body):
	if body.is_in_group("enemies"):
		if enemies.has(body):
			enemies[body].queue_free()
			enemies.erase(body)
