extends Node3D

var focusedEnitity = null

var heldItem = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("drop"):
		if heldItem != null:
			yeet(heldItem)
	if event.is_action_pressed("interact"):
		if is_instance_valid(focusedEnitity):
			if focusedEnitity.is_in_group("Item"):
				if heldItem == null:
					grab(focusedEnitity)
			else:
				focusedEnitity.interact()

func grab(item:RigidBody3D):
	if heldItem != null:
		print("no room to grab")
		return
	print("I can haz ",item.type)
	item.freeze = true
	item.reparent($ItemHolder/Slot1,false)
	item.set_deferred("position",Vector3.ZERO)
	heldItem = item
	pass

func yeet(item:RigidBody3D):
	item.reparent(get_tree().current_scene)
	item.freeze = false
	item.apply_central_impulse(Vector3(3,0,0).rotated(Vector3(0,1,0),rotation.y))
	heldItem = null
	pass

func update_selection(): # each time an object enters/leave the interaction box an update is needed
	for L in get_tree().get_nodes_in_group("Interact"): # dirty deselct all, might need upgrade later
		L.deselect()
	var validSelectables = []
	for A in $InteractionBox.get_overlapping_bodies():
		if A.select_is_valid():
			validSelectables.push_back(A)
	if validSelectables.size() == 0:
		focusedEnitity = null
		return
	var winner = validSelectables[0]
	for W in validSelectables:
		if $InteractionBox.global_position.distance_to(winner.global_position) > $InteractionBox.global_position.distance_to(W.global_position):
			winner = W
	winner.select()
	focusedEnitity = winner
	pass

func get_held_item():
	return heldItem
	pass

func _on_interaction_box_body_entered(body):
	update_selection()
	print(body)
	pass # Replace with function body.


func _on_interaction_box_body_exited(body):
	update_selection()
	pass # Replace with function body.
