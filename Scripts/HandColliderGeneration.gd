@tool
extends CollisionPolygon2D


@export var hand_radious : float = 1:
	set(value):
		hand_radious = value
		generateShape()

@export var thickness : float = 1.2:
	set(value):
		thickness = value
		generateShape()

@export var detail : int = 5:
	set(value):
		detail = value
		generateShape()

@export var arch_percec : float = 0.5:
	set(value):
		arch_percec = value
		generateShape()

@export var regenerate : bool = false:
	set(value):
		regenerate = false
		generateShape()


func get_outter_radious() -> float:
	return thickness*hand_radious

func generateShape():
	var new_vertices : PackedVector2Array = PackedVector2Array()
	var total_arch = 2*PI*arch_percec
	var delta_a = total_arch / (detail-1)
	for i in range(1, detail-1):
		var actual_a = delta_a*i
		new_vertices.append(hand_radious*Vector2(-cos(actual_a), sin(actual_a)))
	
	var outter_radious : float = hand_radious*thickness
	for i in range(detail):
		var actual_a = total_arch - delta_a*i
		new_vertices.append(outter_radious *Vector2(-cos(actual_a), sin(actual_a)))
	
	polygon = new_vertices

