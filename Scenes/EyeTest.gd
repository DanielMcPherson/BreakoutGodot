extends Node2D

func _ready():
	$EyeParent/Eyes.set_look_target($Ball)
