extends Node2D

# Don't immediately switch back to title screen
var can_switch = false

func _ready():
	can_switch = false
	$BackToTitle.visible = false


func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and can_switch:
		get_tree().change_scene(Global.title)

func _on_Timer_timeout():
	$BackToTitle.visible = true
	can_switch = true
