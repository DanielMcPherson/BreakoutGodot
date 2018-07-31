extends StaticBody2D

var main
var hits = 0
export var dead = false
const MAX_HITS = 2


func _ready():
	randomize()
	add_to_group("bricks")
		# Call function to delete brick after die animation finishes
	$AnimatedSprite.connect("animation_finished", self, "die_animation_finished")
	reload()


func reload():
	dead = false
	hits = 0
	$CollisionShape2D.disabled = false
	$AnimatedSprite.visible = true
	$AnimatedSprite.play("0")
	Global.num_bricks += 1


# Called from ball script when brick has been hit by a ball
func hit():
	hits += 1
	if hits <= MAX_HITS:
		# Show animation for current number of hits
		$AnimatedSprite.play(str(hits))
		Global.GameState.brick_hit()
	else:
		# Brick is completely destroyed
		die()
	return dead


func die():
	dead = true
	Global.GameState.brick_destroyed()
	# Disable collider so we don't hit this brick again
	$CollisionShape2D.disabled = true
	# Choose between two die animations
	var animation = "die1"
	if randi() % 100 > 49:
		animation = "die2"
	$AnimatedSprite.play(animation)


# Delete brick object after die animation has finished
func die_animation_finished():
	$AnimatedSprite.visible = false
	Global.num_bricks -= 1