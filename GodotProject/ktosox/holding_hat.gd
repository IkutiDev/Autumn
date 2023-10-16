extends Node3D

# it is the hat that holds... items, in air, above the player's head

var focusedEnitity = null # what the ploayer is currently looking at

var heldItem = null # 

func _ready():
	InputManager.drop.connect(drop_action)
	InputManager.interact.connect(interact_action)
	update_glow_state()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		rotate_held()

func drop_action():
	if heldItem != null:
		yeet(heldItem)
	pass

func interact_action():
	if is_instance_valid(focusedEnitity):
		if focusedEnitity.is_in_group("Item"):
			if heldItem == null:
				grab(focusedEnitity)
		else:
			focusedEnitity.interact()
	pass
	

func grab(item:RigidBody3D):
	if heldItem != null:
		print("no room to grab")
		return

	item.freeze = true
	item.reparent($ItemHolder/Slot1,false)
	item.set_deferred("position",Vector3.ZERO)
	heldItem = item
	update_glow_state()
	pass

func yeet(item:RigidBody3D):
	item.reparent(get_tree().current_scene)
	item.freeze = false

	item.apply_central_impulse(Vector3(3,0,0).rotated(Vector3(0,1,0),global_rotation.y))
	heldItem = null
	update_glow_state()
	pass

func rotate_held():
	var oldOrder = [$ItemHolder/Slot1.get_children(),$ItemHolder/Slot2.get_children(),$ItemHolder/Slot3.get_children()]
	var newOrder = [$ItemHolder/Slot2,$ItemHolder/Slot3,$ItemHolder/Slot1]
	for Zorb in range(3):
		if oldOrder[Zorb].size() != 0:
			oldOrder[Zorb][0].reparent(newOrder[Zorb],false)
	if $ItemHolder/Slot1.get_children().size() == 0:
		heldItem = null
	else:
		heldItem = $ItemHolder/Slot1.get_children()[0]
	update_glow_state()
	pass

func update_selection(): # each time an object enters/leave the interaction box an update is needed
	if focusedEnitity != null:
		focusedEnitity.deselect()
	var validSelectables = []
	for A in $InteractionBox.get_overlapping_bodies():
		if A.select_is_valid():
			if A != heldItem:
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

func update_glow_state():
	for I in get_tree().get_nodes_in_group("Interact"):
		I.update_glow(heldItem)
	pass

func get_held_item():
	return heldItem
	pass

func _on_interaction_box_body_entered(body):
	update_selection()

	pass # Replace with function body.


func _on_interaction_box_body_exited(body):

	update_selection()
	pass # Replace with function body.





func _on_slot_1_child_order_changed():
	if $ItemHolder/Slot1.get_child_count() == 0:
		heldItem = null
	update_glow_state()
	pass # Replace with function body.
