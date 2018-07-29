extends Sprite

var score = 0
var displayed_score = 0


func _ready():
	pass


func set_score(new_score):
	score = new_score


func _on_Timer_timeout():
	if displayed_score < score:
		displayed_score += 1
		$Score.text = str(displayed_score)
