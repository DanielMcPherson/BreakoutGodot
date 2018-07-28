extends Node2D

func _ready():
	$Paddle/Eyes.set_look_target($Ball)
	$Paddle.set_ball($Ball)
	$Ball.set_paddle($Paddle)