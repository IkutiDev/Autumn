extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += Vector3(int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left")),0,int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up"))) * delta * 10

func update_selection(): # each time an object enters/leave the interaction box an update is needed
	for L in get_tree().get_nodes_in_group("Interact"): # dirty deselct all, might need upgrade later
		L.deselect()
	var validSelectables = []
	for A in $InteractionBox.get_overlapping_areas():
		if A.select_is_valid():
			validSelectables.push_back(A)
	if validSelectables.size() == 0:
		return
	var winner = validSelectables[0]
	for W in validSelectables:
		if $InteractionBox.global_position.distance_to(winner.global_position) > $InteractionBox.global_position.distance_to(W.global_position):
			winner = W
	winner.select()
		
	pass

func _on_interaction_box_area_entered(area):
	update_selection()
	pass # Replace with function body.


func _on_interaction_box_area_exited(area):
	update_selection()
	pass # Replace with function body.
