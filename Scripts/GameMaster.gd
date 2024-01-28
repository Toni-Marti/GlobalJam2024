extends Node2D

var bola_prefab :Resource = load("res://Escenas/bola.tscn")

func instantiateBall(pos :Vector2):
	pass

func startGame():
	var tweener = create_tween()
	var hands_pos : Vector2 = Vector2(get_viewport_rect().size.x/6, get_viewport_rect().size.y/2.5)
	
	$LeftHand.pos_with_no_offset = Vector2(-hands_pos.x, hands_pos.y)
	$LeftHand.position = $LeftHand.pos_with_no_offset
	$RightHand.pos_with_no_offset = hands_pos
	$RightHand.position = $RightHand.pos_with_no_offset
	
	tweener.tween_property($LeftHand, "can_move", true, 0.5)
