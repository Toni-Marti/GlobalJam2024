extends Node2D

var bola_prefab :Resource = load("res://Escenas/bola.tscn")

var score = 0

func scored():
	score += 1
	print(score)

func addBall(left:bool):
	$LeftHand.ball_exited.disconnect(addBallLeft)
	$RightHand.ball_exited.disconnect(addBallRigth)
	
	var hand : Node2D
	var arm : Node2D
	var sprite_brazo_espalda : Node2D
	if left:
		hand = $LeftHand
		arm = $BrazoI
		sprite_brazo_espalda = $Payaso/BrazoEspaldaI
	else:
		hand = $RightHand
		arm = $BrazoD
		sprite_brazo_espalda = $Payaso/BrazoEspaldaD
	
	await  get_tree().create_timer(0.3).timeout
	
	hand.visible = false
	hand.can_move = false
	arm.visible = false
	sprite_brazo_espalda.visible = true
	
	await get_tree().create_timer(0.5).timeout
	hand.visible = true
	hand.can_move = true
	arm.visible = true
	sprite_brazo_espalda.visible = false
	instantiateBall(hand.global_position)

func addBallLeft():
	addBall(true)

func addBallRigth():
	addBall(false)

func _ready():
	$LeftHand.ball_exited.connect(addBallLeft)
	$RightHand.ball_exited.connect(addBallRigth)


func instantiateBall(pos :Vector2, hand : RigidBody2D = null):
	var new_ball = bola_prefab.instantiate()
	new_ball.position = pos
	if hand:
		new_ball.last_hand = hand
	new_ball.socred.connect(scored)
	add_child(new_ball)

func positionHandsAndBalls():
	var hands_pos : Vector2 = Vector2(get_viewport_rect().size.x/6, get_viewport_rect().size.y/2.5)
	
	$LeftHand.pos_with_no_offset = Vector2(-hands_pos.x, hands_pos.y)
	$LeftHand.position = $LeftHand.pos_with_no_offset
	$RightHand.pos_with_no_offset = hands_pos
	$RightHand.position = $RightHand.pos_with_no_offset
	
	await get_tree().create_timer(0.1).timeout
	instantiateBall($LeftHand.global_position)
	instantiateBall($RightHand.global_position)

func setHandlsMovment(value : bool):
	$LeftHand.can_move = value
	$RightHand.can_move = value

func handsCanMove():
	setHandlsMovment(true)

func handsCanNotMove():
	setHandlsMovment(false)

func startGame():
	positionHandsAndBalls()
	get_tree().create_timer(0.8).timeout.connect(handsCanMove)
