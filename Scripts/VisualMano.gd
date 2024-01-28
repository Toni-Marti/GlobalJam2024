extends Node2D


func _process(delta):
	if not get_parent().target:
		return
	
	var target = get_parent().target
	look_at(target.global_position)
	
	if abs(global_position.x) > 120:
		$Lateral.visible = true
		$Frontal.visible = false
	else:
		$Lateral.visible = false
		$Frontal.visible = true
		
