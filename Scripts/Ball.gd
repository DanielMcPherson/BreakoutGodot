extends KinematicBody2D

const SPEED = 8

export var motion = Vector2()
export var started = false
export var lost = false
var starting_position


func _ready():
	Global.Ball = self
	starting_position = position
	reset()


func reset():
	position = starting_position
	motion.x = 0
	motion.y = 0
	started = false
	lost = false


func start():
	motion.y = -SPEED
	motion.x = SPEED / 2
	started = true


func increase_speed(multiplier):
	motion *= multiplier


func _physics_process(delta):
	if lost:
		return
	if not started:
		$AnimatedSprite.play("default")
		return
	var collision_info = move_and_collide(motion)
	if collision_info:
		# Bounce off object we have collided with
		motion = motion.bounce(collision_info.normal)
		# See if the other object is a brick
		var other = collision_info.collider
		if other.is_in_group("bricks"):
			# Tell the brick it has been hit
			var brick_destoryed = other.hit()
			# Ball is happy about it
			if other.position.y < position.y:
				# Smile when hitting ball from below
				if brick_destoryed:
					$Sounds/DestoryBrick.play()
					$AnimatedSprite.play("big_smile")
				else:
					$Sounds/HitBrick.play()
					$AnimatedSprite.play("smile")
			else:
				# Murderous glee when hitting ball from above
				$AnimatedSprite.play("angry")
			# Tell paddle if we smashed a brick
			if brick_destoryed:
				Global.Paddle.brick_smashed()
		elif "Paddle" in other.get_name():
			$Sounds/PaddleSound.play()
			# Ball is happy
			$AnimatedSprite.play("default")
			# Tell main script we hit paddle
			Global.GameState.ball_hit_top_or_paddle()
			# Tell paddle we've hit it
			Global.Paddle.hit_ball()
		elif "Wall" in other.get_name():
			$Sounds/WallSound.play()
			if "TopWall" in other.get_name():
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

func _on_VisibilityNotifier2D_screen_exited():
		Global.GameState.ball_hit_bottom()
		$Sounds/LostBallSound.play()
		lost = true
