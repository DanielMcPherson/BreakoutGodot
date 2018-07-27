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
			# Ball is happy about it
			if other.position.y < position.y:
				# Big smile when hitting ball from below
				$AnimatedSprite.play("big_smile")
			else:
				# Murderous glee when hitting ball from above
				$AnimatedSprite.play("angry")
		elif "Paddle" in other.get_name():
			# Ball is happy
			$AnimatedSprite.play("smile")
	# Ball gets nervouse when falling down
	if motion.y > 0:
		if position.y > 620:
			$AnimatedSprite.play("worried")
	if motion.y < 0 and position.y > 550:
		$AnimatedSprite.play("default")
	# Ball is confused if not moving up and down fast enough
	if abs(motion.y) < 3:
		$AnimatedSprite.play("confused")