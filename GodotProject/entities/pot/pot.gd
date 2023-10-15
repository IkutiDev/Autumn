extends RigidBody3D

var eating = false

var itemMemory = []
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func interact():
	if eating:
		return
	var itemHeldByHat = get_tree().get_nodes_in_group("Hat")[0].heldItem
	if  itemHeldByHat != null:
		if itemHeldByHat.isReagent:
			om_nom_nom(itemHeldByHat)
	pass

func select_is_valid():
	return !eating

func select():
	$MeshInstance3D3.visible = true
	pass
	
func deselect():
	$MeshInstance3D3.visible = false
	pass

func om_nom_nom(item:RigidBody3D):
	eating = true
	item.freeze = true
	$ItemPath.curve.set_point_position(0,to_local(item.global_position))
	item.reparent($ItemPath/Grab,false)
	

	$ItemPath/Mover.play("EatAnimation")
	await($ItemPath/Mover.animation_finished)
	consume(item)
	#create a path between the item and the pot and move the item along the path
	pass

func consume(item:RigidBody3D):
	itemMemory.push_back(item.type)
	item.queue_free()
	eating = false
	if itemMemory.size()>2:
		puke()
	pass

func puke():
	# some smart code for picking what item to make
	itemMemory.clear()
	var resultItem = load("res://entities/items/blue_goop.tscn").instantiate() as RigidBody3D
	resultItem.global_position = $Output.global_position
	get_tree().current_scene.add_child(resultItem)
	resultItem.apply_central_impulse(Vector3(7,0,0).rotated(Vector3(0,1,0),randf()*2*PI))
	pass



