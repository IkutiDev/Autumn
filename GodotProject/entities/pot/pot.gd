extends RigidBody3D

var eating = false

var itemMemory = []

var isFull = true





var fireworkScene = preload("res://particles/firework.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	should_be_full(false)


	pass # Replace with function body.

func interact():
	if eating or !isFull:
		return
	var itemHeldByHat = get_tree().get_nodes_in_group("Hat")[0].heldItem
	if  itemHeldByHat != null:
		if itemHeldByHat.isReagent:
			om_nom_nom(itemHeldByHat)
	pass

func select_is_valid():
	return isFull

func select():
	$SelectionUpscale/SelectionBox.visible = true
	pass
	
func deselect():
	$SelectionUpscale/SelectionBox.visible = false
	pass

func update_glow(heldItem):
	if !isFull:
		$GPUParticles3D.emitting = false
	elif heldItem == null:
		$GPUParticles3D.emitting = false
	elif heldItem.isReagent:
		$GPUParticles3D.emitting = true
	else:
		$GPUParticles3D.emitting = false

func om_nom_nom(item:RigidBody3D):
	eating = true
	$ItemPath.move_item(item)

	pass

func consume(item:RigidBody3D):
	itemMemory.push_back(item.type)
	item.queue_free()
	eating = false
	var firework = fireworkScene.instantiate()
	firework.global_position = $Output.global_position
	add_child(firework)
	firework.apply_central_impulse(Vector3(1,1,0).rotated(Vector3(0,1,0),randf()*2*PI))
	
	
	
	if itemMemory.size()>2:
		puke()
	pass

func puke():
	# some smart code for picking what item to make
	var result = ItemBase.ITEM_TYPE.Junk
	for R in RecipeManager.allValidRecipies.keys():
		var testedRecipie = R.duplicate()
		for I in itemMemory:
			testedRecipie.erase(I)
		if testedRecipie.is_empty():
			result = RecipeManager.allValidRecipies[R]

	itemMemory.clear()
	var resultItem = RecipeManager.temToItemTypeMap[result].instantiate()
	resultItem.global_position = $Output.global_position
	get_tree().current_scene.add_child(resultItem)
	resultItem.apply_central_impulse(Vector3(7,0,0).rotated(Vector3(0,1,0),randf()*2*PI))
	pass


func should_be_full(beFull):
	if beFull != isFull:
		if beFull:
			$FullnesAnimator.play("Full")
			isFull = true
			pass
		else:
			$FullnesAnimator.play("Empty")
			isFull = false
			itemMemory.clear()
			$Bubbling.stop()
			pass
	pass


func _on_item_path_moving_complete(item):
	consume(item)
	pass # Replace with function body.



func _on_bubbling_finished():
	$Bubbles.emitting = true
	$Bubbling.call_deferred("play")
	pass # Replace with function body.
