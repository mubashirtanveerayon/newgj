extends "res://utils/projectile/projectile.gd"


func on_area_entered(area):
	var particles = BulletImpactParticles.new()
	particles.global_position = global_position
	get_tree().get_first_node_in_group("world").add_child(particles)
	super.on_area_entered(area)
