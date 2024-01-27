extends Node2D

func _ready():
	startGame()

func startGame():
	var hands_pos : Vector2 = Vector2(get_viewport_rect().size.x/6, get_viewport_rect().size.y/2.5)
	print(hands_pos)
	
	$LeftHand.pos_with_no_offset = Vector2(-hands_pos.x, hands_pos.y)
	$RightHand.pos_with_no_offset = hands_pos
