extends AnimatableBody2D

signal ball_exited
signal ball_enteted

@export var left_hand :bool = true
@export var mov_angle :float = PI/12
@export var h_accel :float = 1000
@export var max_h_vel :float = 600
@export var down_vel :float = 1
@export var max_down_dist : float = 100

@export var target : Node2D

var left_action : String
var right_action : String
var hold_action : String

var curr_h_vel :float = 0
var slowdown_factor = 1.5
var held_down_timer : float
var hold_mov_vec : Vector2 = Vector2(-sin(mov_angle), cos(mov_angle))
var pos_with_no_offset : Vector2
var hold_offset : Vector2 = Vector2()
var movment_bounds : Vector2
var can_move = false

var ball_on_hand : Ball = null
var tweening = false
@export var magnet_force : float = 60000
var col_layer_index : int


func _ready():
	var ball_radious = $HandCollider.get_outter_radious()
	pos_with_no_offset = position
	
	if left_hand:
		left_action = "L_hand_l"
		right_action = "L_hand_r"
		hold_action = "L_hand_hold"
		movment_bounds = Vector2(-get_viewport_rect().size.x/2 - ball_radious, -ball_radious)
		col_layer_index = 1
	else:
		left_action = "R_hand_l"
		right_action = "R_hand_r"
		hold_action = "R_hand_hold"
		hold_mov_vec.x = -hold_mov_vec.x
		movment_bounds = Vector2(ball_radious, get_viewport_rect().size.x/2 + ball_radious)
		col_layer_index = 2
		$Sprites.scale.y = -1

func setBallCollisionMask(ball, time, mask):
	await get_tree().create_timer(time).timeout
	ball.collision_mask = mask

func _physics_process(delta):
	if not can_move:
		return
	
	# MOVMENT
	var tring_to_move : bool = false
	var moving_oposite : bool = false
	
	if Input.is_action_pressed(left_action):
		curr_h_vel -= h_accel*delta
		curr_h_vel = max(curr_h_vel, -max_h_vel)
		tring_to_move = not tring_to_move
		
		if curr_h_vel > 0:
			moving_oposite = true
	
	if Input.is_action_pressed(right_action):
		curr_h_vel += h_accel*delta
		curr_h_vel = min(curr_h_vel, max_h_vel)
		tring_to_move = not tring_to_move
		
		if curr_h_vel < 0:
			moving_oposite = true
	
	if (not tring_to_move) or moving_oposite:
		if curr_h_vel > 0:
			curr_h_vel -= h_accel*slowdown_factor*delta
			curr_h_vel = max(curr_h_vel, 0)
		elif curr_h_vel < 0:
			curr_h_vel += h_accel*slowdown_factor*delta
			curr_h_vel = min(curr_h_vel, 0)
	
	pos_with_no_offset.x += curr_h_vel*delta
	pos_with_no_offset.x = min(max(pos_with_no_offset.x, movment_bounds.x), movment_bounds.y)
	if curr_h_vel < 0 and pos_with_no_offset.x == movment_bounds.x:
		curr_h_vel = 0
	if curr_h_vel > 0 and pos_with_no_offset.x == movment_bounds.y:
		curr_h_vel = 0
	
	if Input.is_action_just_pressed(hold_action):
		held_down_timer = 0
	
	if Input.is_action_pressed(hold_action):
		hold_offset = hold_mov_vec*Utils.arctan_inetrpolation(held_down_timer, max_down_dist, down_vel)
		held_down_timer += delta
	
	position = pos_with_no_offset + hold_offset
	
	
	# BALL LAUNCHING
	if Input.is_action_just_released(hold_action):
		var tween = create_tween()
		tweening = true
		tween.tween_property(self, "hold_offset", -hold_offset, 0.1).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "hold_offset", Vector2(), 0.05).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "tweening", false, 0)
		
		if not ball_on_hand:
			return
		
		
		var curr_collision_mask = ball_on_hand.collision_mask
		ball_on_hand.set_collision_mask_value(col_layer_index, false)
		
		ball_on_hand.apply_central_impulse(-ball_on_hand.linear_velocity*ball_on_hand.mass*0.9)
		
		var impulse = -hold_mov_vec * hold_offset.length()*5
		if impulse.length() == 0:
			impulse = -hold_mov_vec	
		if impulse.length() < 40:
			impulse = impulse.normalized() * 40
		ball_on_hand.apply_central_impulse(impulse)
		
		setBallCollisionMask(ball_on_hand, 0.05, curr_collision_mask)
	
	# BALL MAGNET
	if ball_on_hand and not tweening:
		ball_on_hand.apply_central_force(($ImpulseTarget.global_position - ball_on_hand.global_position).normalized() * magnet_force * delta)


func _on_body_entered(body):
	if tweening or ball_on_hand:
		return
	ball_on_hand = body
	body.lastHand = self


func _on_body_exited(body):
	ball_exited.emit()
	if body == ball_on_hand:
		ball_on_hand = null
