extends Node2D

@export var target : Node2D

func _process(delta):
	if not target:
		return
	
	look_at(target.global_position)
	rotation += PI/2
	$CuerpoBrazo.global_scale.y = max(global_position.distance_to(target.global_position) - $CuerpoBrazo.position.y/$CuerpoBrazo.global_scale.y, 0)
