extends DayCycle



func start():
	# show sum up screen
	# pause scene tree
	print("Night starts")
	get_tree().current_scene.add_child(load("res://core/end_day_screen.tscn").instantiate())
	cycleTimer.stop() # since it's not timed base but a confirmation based state
	pass
	
func stop():
	
	print("Night ends")
	pass
