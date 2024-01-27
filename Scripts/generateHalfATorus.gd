@tool
extends CollisionPolygon2D

@export var inner_rad :float = 30
@export var outter_rad :float = 40
@export var detail :float = 5

@export var regenerate : bool = false:
	set(value):
		regenerate = false
		generateShape()

func generateShape():
	var new_vertices : PackedVector2Array = PackedVector2Array()
	var delta_a = PI/(detail-1)
	
	for i in range(detail):
		var actual_a = delta_a*i
		new_vertices.append(inner_rad*Vector2(cos(actual_a), -sin(actual_a)))
	
	for i in range(detail):
		var actual_a = PI - delta_a*i
		new_vertices.append(outter_rad*Vector2(cos(actual_a), -sin(actual_a)))
	
	polygon = new_vertices
