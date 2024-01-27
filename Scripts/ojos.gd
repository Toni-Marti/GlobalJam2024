extends Node2D

@export var target: Node2D
@export var radio: float = 8
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not target:
		return
	
	var vector_hacia:Vector2 = target.global_position - global_position
	if target.global_position != global_position:
		vector_hacia = vector_hacia.normalized()
	
	$pupuila.position = vector_hacia * radio
	
