extends Node2D

var score = 0
var displayed_score = 0
var started = false


func _ready():
	Global.GameState = self
	$Paddle/Eyes.set_look_target($Ball)
	score = 0
	displayed_score = 0
	update_score_ui()
	reset()


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


func brick_hit():
	score += 10
	update_score_ui()


func brick_destroyed():
	score += 50
	update_score_ui()


func reset():
	started = false
	$StartPrompt.visible = true


func ball_hit_bottom():
	Global.Ball.reset()
	reset()


func ball_hit_top_or_paddle():
	# Ball is out of the way, so we can reload bricks
	# if we need to
	if Global.num_bricks <= 0:
		get_tree().call_group("bricks", "reload")
		Global.Ball.increase_speed(1.1)