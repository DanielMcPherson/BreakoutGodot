extends Sprite

export var radius = 18
var look_at

func _ready():
	pass


func set_look_target(obj):
	look_at = obj


func _physics_process(delta):
	if look_at:
		var angle = get_parent().position.angle_to_point(look_at.position)
		$LeftEye/LeftSprite.position.x = -radius * cos(angle)
		$LeftEye/LeftSprite.position.y = -radius * sin(angle)
		$RightEye/RightSprite.position.x = -radius * cos(angle)	
		$RightEye/RightSprite.position.y = -radius * sin(angle)
