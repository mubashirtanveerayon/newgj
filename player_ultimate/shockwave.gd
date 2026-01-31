extends Node2D

func _ready():
	
	var screen_size = get_viewport_rect().size
	var max_dim = max(screen_size.x, screen_size.y)
	var target_radius = max_dim / 2.0
	
	var visual = $ColorRect
	visual.size = screen_size
	visual.position = -visual.size / 2
	
	# 3. Setup Collider
	var area = $Area2D
	var collider = $Area2D/CollisionShape2D
	
	# Ensure unique shape and start at radius 0 (so nobody dies yet)
	if collider.shape == null: collider.shape = CircleShape2D.new()
	else: collider.shape = collider.shape.duplicate()
	
	collider.shape.radius = 0.0 


	# 5. SYNCED ANIMATION
	var mat = visual.material as ShaderMaterial
	var tween = create_tween()
	
	# Visual: Expand the shader ring
	tween.tween_property(mat, "shader_parameter/size", 1.2, 0.5).from(0.0)
	
	# Physics: Expand the kill circle at the exact same speed
	tween.parallel().tween_property(collider.shape, "radius", target_radius, 0.5).from(0.0)
	
	# Visual: Fade out the distortion force
	tween.parallel().tween_property(mat, "shader_parameter/force", 0.0, 0.5).from(0.8)
	
	await tween.finished
	queue_free()
