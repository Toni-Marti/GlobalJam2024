extends Node2D

@export var target: Node2D
@export var radio: float = 8
var max_dist :float = 300.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not target:
		return
	
	var vector_hacia:Vector2 = target.global_position - global_position
	var dist_ratio = min(vector_hacia.length()/max_dist, 1)
	if vector_hacia.length() != 0:
		vector_hacia = vector_hacia.normalized()
	
	$pupuila.position = vector_hacia * radio * dist_ratio
	
