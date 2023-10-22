extends DayCycle



func start():
	# show sum up screen
	# pause scene tree
	print("Night starts")

	if GameManager.current_day_customers_done >= GameManager.customers_to_complete[GameManager.day_index]:
		get_tree().current_scene.add_child(load("res://core/end_day_screen.tscn").instantiate())
	else:
		GameManager.change_to_game_over_scene()
	cycleTimer.stop() # since it's not timed base but a confirmation based state
	GameManager.night_summary.emit()
	pass
	
func stop():
	
	print("Night ends")
	pass
