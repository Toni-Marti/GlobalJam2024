extends AnimationPlayer

var tweening

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	#play("telon_up")
	var tween = create_tween()
	var telon = get_parent()
	var boton = get_parent().get_node("boton")
	print(telon.position)
	tween.tween_property(telon, "position", Vector2(0, -1000), 1).as_relative().set_trans(Tween.TRANS_ELASTIC)
	#tween.tween_property(boton, "position", Vector2(0, -1000), 1).as_relative().set_ease(Tween.EASE_IN_OUT)
