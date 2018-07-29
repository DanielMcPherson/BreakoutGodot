extends Node

var Paddle
var Ball
var num_bricks = 0


func _process(delta):
	# Magic debug keystroke to destroy all bricks
	if Input.is_action_pressed("ui_accept"):
		get_tree().call_group("bricks", "die")
	if Input.is_action_pressed("ui_up"):
		Ball.increase_speed(1.06)


func ball_hit_top_or_paddle():
	# Ball is out of the way, so we can reload bricks 
	# if we need to
	if num_bricks <= 0:
		get_tree().call_group("bricks", "reload")
		Ball.increase_speed(1.1)