extends KinematicBody2D

const SPEED = 8

export var motion = Vector2()


func _ready():
	Global.Ball = self
	motion.y = SPEED
	motion.x = SPEED / 2


func increase_speed(multiplier):
	motion *= multiplier


func _physics_process(delta):
	var collision_info = move_and_collide(motion)
	if collision_info:
		# Bounce off object we have collided with
		motion = motion.bounce(collision_info.normal)
		# See if the other object is a brick
		var other = collision_info.collider
		if "Brick" in other.get_name():
			# Tell the brick it has been hit
			var brick_destoryed = other.hit()
			# Ball is happy about it
			if other.position.y < position.y:
				# Smile when hitting ball from below
				if brick_destoryed:
					$AnimatedSprite.play("big_smile")
				else:
					$AnimatedSprite.play("smile")
			else:
				# Murderous glee when hitting ball from above
				$AnimatedSprite.play("angry")
			# Tell paddle if we smashed a brick
			if brick_destoryed:
				Global.Paddle.brick_smashed()
		elif "Paddle" in other.get_name():
			# Ball is happy
			$AnimatedSprite.play("default")
			# Tell main script we hit paddle
			Global.GameState.ball_hit_top_or_paddle()
		elif "TopWall" in other.get_name():
			Global.GameState.ball_hit_top_or_paddle()
	# Ball gets nervouse when falling down
	if motion.y > 0:
		# ToDo: Look worried if ball is below 650 and paddle is not close enough
		if position.y > 710:
			$AnimatedSprite.play("worried")
	if motion.y < 0 and position.y > 550:
		$AnimatedSprite.play("default")
	# Ball is confused if not moving up and down fast enough
	if abs(motion.y) < 3:
		$AnimatedSprite.play("confused")
	# Make sure ball doesn't get stuck only moving horizontally
	if abs(motion.y) < 2:
		motion.y *= 1.1