extends Node2D

var score = 0


func _ready():
	Global.GameState = self
	$Paddle/Eyes.set_look_target($Ball)
	score = 0


func _process(delta):
	# Magic debug keystroke to destroy all bricks
	if Input.is_action_pressed("ui_accept"):
		get_tree().call_group("bricks", "die")
	if Input.is_action_pressed("ui_up"):
		Global.Ball.increase_speed(1.06)


func update_score_ui():
	$Banner/Score.text = str(score)


func brick_hit():
	score += 10
	update_score_ui()


func brick_destroyed():
	score += 50
	update_score_ui()


func ball_hit_top_or_paddle():
	# Ball is out of the way, so we can reload bricks
	# if we need to
	if Global.num_bricks <= 0:
		get_tree().call_group("bricks", "reload")
		Global.Ball.increase_speed(1.1)