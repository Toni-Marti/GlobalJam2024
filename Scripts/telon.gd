extends Node

func subeTelon():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(0, -1100), 1).set_trans(Tween.TRANS_ELASTIC)

func bajaTelon():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(0, 0), 1).set_trans(Tween.TRANS_ELASTIC)
