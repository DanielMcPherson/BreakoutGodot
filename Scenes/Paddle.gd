extends KinematicBody2D

const SPEED = 15

var motion = Vector2()


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _physics_process(delta):
	motion.x = 0
	if Input.is_action_pressed("ui_left"):
		motion.x -= SPEED
	elif Input.is_action_pressed("ui_right"):
		motion.x += SPEED
	motion.y = 0
	move_and_collide(motion)
