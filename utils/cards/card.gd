extends Node2D

class_name Card

@export var description:String=""
@export var name_to_show:String=""
@export var icon: Texture2D



# virtual methods 
# ---------------

func on_acquire(context:Node2D):
	pass

func on_attack(context:Node2D):
	return context
