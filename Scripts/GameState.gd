extends Node2D

var score = 0
var displayed_score = 0
var started = false
var num_extra_balls = 3


func _ready():
	Global.GameState = self
	$Paddle/Eyes.set_look_target($Ball)
	score = 0
	displayed_score = 0
	update_score_ui()
	reset_ball()


func _process(delta):
	# Magic debug keystroke to destroy all bricks
	if Input.is_action_pressed("ui_down"):
		get_tree().call_group("bricks", "die")
	if not started:
		if Input.is_action_pressed("ui_select"):
			started = true
			Global.Ball.start()
			$StartPrompt.visible = false
		else:
			Global.Ball.position.x = Global.Paddle.position.x + 32


func update_score_ui():
	#$Banner/Score.text = str(displayed_score)
	$ScoreBanner.set_score(score)


func increase_score(points):
	var new_score = score + points
	# Award extra balls at score milestones
	var score_milestones = [ 500, 1000, 2500, 5000, 10000 ]
	for milestone in score_milestones:
		if score < milestone and new_score >= milestone:
			change_ball_count(1)
			$ExtraBall.play()
			$BallCountDisplay/AnimationPlayer.play("NewBall")
	score = new_score
	update_score_ui()


func brick_hit():
	increase_score(10)
	$Camera.shake(.1, 0.8)


func brick_destroyed():
	increase_score(50)
	$Camera.shake(.25, 1)


func ball_hit_bottom():
	$Camera.shake(2, 2)
	$BallResetTimer.start()


func _on_BallResetTimer_timeout():
	reset_ball()


func change_ball_count(change):
	num_extra_balls += change
	$BallCountDisplay/BallCount.text = str(num_extra_balls)


func reset_ball():
	if num_extra_balls <= 0:
		get_tree().change_scene(Global.game_over)
	Global.Ball.reset()
	change_ball_count(-1)
	started = false
	$StartPrompt.visible = true


func ball_hit_top_or_paddle():
	# Ball is out of the way, so we can reload bricks
	# if we need to
	if Global.num_bricks <= 0:
		get_tree().call_group("bricks", "reload")
		Global.Ball.increase_speed(1.1)

