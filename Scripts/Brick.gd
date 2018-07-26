extends StaticBody2D

var hits = 0
const MAX_HITS = 2

func _ready():
	randomize()

func hit():
	hits += 1
	if hits <= MAX_HITS:
		$AnimatedSprite.play(str(hits))
	else:
		$CollisionShape2D.disabled = true
		# Choose between two die animations
		var animation = "die1"
		if randi() % 100 > 49:
			animation = "die2"
		$AnimatedSprite.play(animation)
		$AnimatedSprite.connect("animation_finished", self, "die_animation_finished")

func die_animation_finished():
	queue_free()