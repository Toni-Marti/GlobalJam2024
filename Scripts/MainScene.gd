extends Node2D

func _ready():
	startGame()

func startGame():
	var hands_pos = Vector2(get_viewport_rect().size.x/6, get_viewport_rect().size.y/8)
	$Hands.position.y = hands_pos.x
	$Hands/LeftHand.position.x = -hands_pos.x
	$Hands/RightHand.position.x = hands_pos.x
