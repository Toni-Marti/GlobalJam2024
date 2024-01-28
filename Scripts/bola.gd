class_name Ball
extends RigidBody2D

signal socred

var lastHand : Node2D = null:
	set(value):
		if lastHand and lastHand != value:
			socred.emit()
		
		lastHand = value


var colors :PackedColorArray = [Color.RED, Color.BLUE, Color.YELLOW, Color.ORANGE, Color.PURPLE]
func _ready():
	$Unified_transform/Rotating/patron.modulate = colors[randi() % colors.size()]

func _physics_process(delta):
	apply_central_force(Vector2())
