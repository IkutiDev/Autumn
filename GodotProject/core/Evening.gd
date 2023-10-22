extends DayCycle


func start():
	GameManager.evening_starts.emit()
	# start spawning customers
	
	# unlock pot
	get_tree().get_nodes_in_group("Pot")[0].should_be_full(true)
	print("Evening starts")

	pass
	
func stop():
	# empty pot
	get_tree().get_nodes_in_group("Pot")[0].should_be_full(false)
	# tell customers to fuck off
	print("Evening ends")
	pass

