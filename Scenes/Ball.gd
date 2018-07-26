extends KinematicBody2D

const SPEED = 8

var motion = Vector2()


func _ready():
	motion.y = SPEED
	motion.x = SPEED / 2


func _physics_process(delta):
	var collision_info = move_and_collide(motion)
	if collision_info:
		# Bounce off object we have collided with
		motion = motion.bounce(collision_info.normal)
		# See if the other object is a brick 
		var other = collision_info.collider
		if "Brick" in other.get_name():
			# Tell the brick it has been hit
			other.hit()