extends StaticBody2D

var hits = 0
const MAX_HITS = 2

func _ready():
	pass

func hit():
	hits += 1
	if hits <= MAX_HITS:
		$AnimatedSprite.play(str(hits))
	else:
		$CollisionShape2D.disabled = true
		$AnimatedSprite.play("die1")
		$AnimatedSprite.connect("animation_finished", self, "die_animation_finished")

func die_animation_finished():
	queue_free()