extends Node2D

@export var target : Node2D
var y_offset :float = 21

func _process(delta):
	if not target:
		return
	
	look_at(target.global_position + Vector2(0, y_offset))
	rotation += PI/2
	var div = max(0.5, $CuerpoBrazo.global_scale.y )
	$CuerpoBrazo.global_scale.y = max(global_position.distance_to(target.global_position) - $CuerpoBrazo.position.y/div - y_offset, 0)
