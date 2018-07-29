extends KinematicBody2D

const SPEED = 15

var motion = Vector2()
var y_pos

func _ready():
	Global.Paddle = self
	# Ball infrequently knocks paddle down
	# Remember starting y position and don't let this happen
	y_pos = position.y


# The paddle's mood depends on how far away the ball is
func check_mood():
	var ball = Global.Ball
	if not ball.started:
		$Mouth.play("smile")
		return
	var dist = position.distance_to(ball.position)
	var hdist = abs(position.x - ball.position.x)
	# If ball is moving up, paddle is happy
	if ball.motion.y < 0:
		$Mouth.play("smile")
	else:
		# If ball gets too low, paddle gets worried
		if ball.position.y > 550:
			$Mouth.play("frown")
		# If balls is below 650 and too far away, get really worried
		if ball.position.y > 650 and hdist > 75:
			$Mouth.play("worried")
	# ToDo: If ball smashes brick, do a big smile


func brick_smashed():
	$Mouth.play("big_smile")


func _physics_process(delta):
	# Handle player input
	motion.x = 0
	if Input.is_action_pressed("ui_left"):
		motion.x -= SPEED
	elif Input.is_action_pressed("ui_right"):
		motion.x += SPEED
	motion.y = 0
	move_and_collide(motion)
	# Don't let y position change
	position.y = y_pos
	# Show proper facial expression
	check_mood()
