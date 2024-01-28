extends AnimationPlayer

func _on_button_pressed():
	var tween = create_tween()
	var telon = get_parent()
	var boton = get_parent().get_node("boton")
	print(telon.position)
	tween.tween_property(telon, "position", Vector2(0, -1200), 1).as_relative().set_trans(Tween.TRANS_ELASTIC)
