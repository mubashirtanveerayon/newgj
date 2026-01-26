extends CPUParticles2D
class_name BulletImpactParticles

func _ready():
	lifetime=0.1
	explosiveness=1
	one_shot=true
	initial_velocity_min=100
	initial_velocity_max=150
	gravity.y=0
	spread=180
	scale_amount_curve=load("res://data/bullet_impact_particle_scale_curve.tres")
	color.g=0
	color.b=0
	color.r=255
	emitting=true
	finished.connect(queue_free)
	
