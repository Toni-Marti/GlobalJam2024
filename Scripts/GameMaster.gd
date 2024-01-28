extends Node2D

var bola_prefab :Resource = load("res://Escenas/bola.tscn")

var balls = []
var score : int = 0
var record : int = 0
var over = false

func scored():
	if over:
		return
	
	score += 1
	$Text/Score/ScoreNum.text = str(score)
	
	if score == 10:
		$Payaso/Boca.texture = load("res://Sprites/Payaso/BocaAbierta.png")
	
	if score == 5:
		$Payaso/Boca.texture = load("res://Sprites/Payaso/BocaU.png")
	
	if score == 2:
		$Payaso/Boca.texture = load("res://Sprites/Payaso/BocaJ.png")

func addBall(left:bool):
	playSong()
	
	$LeftHand.ball_exited.disconnect(addBallLeft)
	$RightHand.ball_exited.disconnect(addBallRigth)
	
	var hand : CollisionObject2D
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
	
	await  get_tree().create_timer(0.2).timeout
	
	var layer = hand.collision_layer
	hand.collision_layer = 0
	hand.visible = false
	hand.can_move = false
	arm.visible = false
	sprite_brazo_espalda.visible = true
	
	await get_tree().create_timer(0.5).timeout
	hand.collision_layer = layer
	hand.visible = true
	hand.can_move = true
	arm.visible = true
	sprite_brazo_espalda.visible = false
	instantiateBall(hand.global_position)

func addBallLeft():
	addBall(true)

func addBallRigth():
	addBall(false)

func setLeftEyeTarget(body):
	$OjoI.target = body

func setRightEyeTarget(body):
	$OjoD.target = body

func _ready():
	$LeftHand/BallEnters.body_entered.connect(setLeftEyeTarget)
	$RightHand/BallEnters.body_entered.connect(setRightEyeTarget)


func instantiateBall(pos :Vector2, hand : RigidBody2D = null):
	var new_ball = bola_prefab.instantiate()
	new_ball.position = pos
	if hand:
		new_ball.last_hand = hand
	new_ball.socred.connect(scored)
	balls.append(new_ball)
	add_child(new_ball)

func positionHandsAndBalls():
	var hands_pos : Vector2 = Vector2(get_viewport_rect().size.x/6, get_viewport_rect().size.y/2.7)
	
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

func playSong():
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.finished.connect(playSong)

func stopSong():
	$AudioStreamPlayer.stop()
	if $AudioStreamPlayer.finished.is_connected(playSong):
		$AudioStreamPlayer.finished.disconnect(playSong)

func startGame():
	$Telon/PayBtn.disabled = true
	for i in range(balls.size()):
		balls[i].queue_free()
	balls.clear()
	
	over = false
	score = 0
	$Payaso/Boca.texture = load("res://Sprites/Payaso/BocaI.png")
	positionHandsAndBalls()
	$Text/Score/ScoreNum.text = "0"
	$Text.visible = true
	await get_tree().create_timer(0.8).timeout
	handsCanMove()
	$LeftHand.ball_exited.connect(addBallLeft)
	$RightHand.ball_exited.connect(addBallRigth)
	$Text.z_index = 0

func gameOver():
	if over:
		return
	
	$Telon/PayBtn.disabled = false
	$Payaso/Boca.texture = load("res://Sprites/Payaso/boca_triste.png")
	over = true
	await get_tree().create_timer(0.5).timeout
	
	if score > record:
		record = score
		$Text/Record/RecordNum.text = str(record)
	
	$Telon.bajaTelon()
	$Text.z_index = 11
	stopSong()

func _on_game_over_zones_body_entered(body):
	gameOver()
