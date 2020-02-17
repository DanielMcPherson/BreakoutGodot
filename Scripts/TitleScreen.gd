extends Node2D

const SELECTED_COLOR = "d63f4a"
const INACTIVE_COLOR = "4a3e33"

var play_selected = true


func _ready():
	play_selected = true
	update_controls()


func _input(event):
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up"):
		play_selected = not play_selected
		update_controls()
	if Input.is_action_just_pressed("ui_accept"):
		if play_selected:
			get_tree().change_scene(Global.main_level)
		else:
			get_tree().change_scene(Global.credits)


func update_controls():
	if play_selected:
		$Play/Label.add_color_override("font_color", Color(SELECTED_COLOR))
		$Play/Sprite.visible = true
		$Credits/Label.add_color_override("font_color", Color(INACTIVE_COLOR))
		$Credits/Sprite.visible = false
	else:
		$Play/Label.add_color_override("font_color", Color(INACTIVE_COLOR))
		$Play/Sprite.visible = false
		$Credits/Label.add_color_override("font_color", Color(SELECTED_COLOR))
		$Credits/Sprite.visible = true
