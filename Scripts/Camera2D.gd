extends Camera2D

var original_viewport_size : Vector2
func _ready():
	original_viewport_size = get_viewport_rect().size

func _process(delta):
	zoom = Vector2(1, 1) * (get_viewport_rect().size.x / original_viewport_size.x)
	pass
