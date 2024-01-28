class_name Ball
extends RigidBody2D

signal socred

var lastHand : Node2D = null:
	set(value):
		if lastHand and lastHand != value:
			socred.emit()
		
		lastHand = value


func _physics_process(delta):
	apply_central_force(Vector2())
