extends Node2D

func _on_boton_pressed():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(0, -1500), 1).as_relative().set_trans(Tween.TRANS_ELASTIC)
	call_deferred(get_parent().startGame(), 1)
