extends Node2D


func _process(delta):
	if not get_parent().target:
		return
	
	var target = get_parent().target
	
	look_at(target.global_position)
