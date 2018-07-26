extends KinematicBody2D

const SPEED = 8

var motion = Vector2()

func _ready():
	motion.y = SPEED
	motion.x = SPEED / 2


func _physics_process(delta):
	var collision_info = move_and_collide(motion)
	if collision_info:
		motion = motion.bounce(collision_info.normal)