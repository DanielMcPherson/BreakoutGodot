extends Camera2D

var initial_offset = Vector2()

func _ready():
	initial_offset = get_offset()


func shake(duration, magnitude):
	print(offset)
	
	var time = 0
	while time < duration:
		time += get_process_delta_time()
		time = min(time, duration)
		
		var offset = Vector2()
		offset.x = rand_range(-magnitude, magnitude)
		offset.y = rand_range(-magnitude, magnitude)
		set_offset(offset)
		
		yield(get_tree(), "idle_frame")
		pass
		
	set_offset(initial_offset)
	print(get_offset())