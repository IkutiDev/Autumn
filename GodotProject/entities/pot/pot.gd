extends RigidBody3D

var eating = false

var itemMemory = []

var validRecipies = {
	[ItemBase.ITEM_TYPE.Apple,ItemBase.ITEM_TYPE.Water,ItemBase.ITEM_TYPE.Water] : ItemBase.ITEM_TYPE.BadApple,
	[ItemBase.ITEM_TYPE.Mushroom,ItemBase.ITEM_TYPE.Mushroom,ItemBase.ITEM_TYPE.Water] : ItemBase.ITEM_TYPE.MushroomJelly,
	[ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Water,ItemBase.ITEM_TYPE.Worm] : ItemBase.ITEM_TYPE.Muffin,
	[ItemBase.ITEM_TYPE.Worm,ItemBase.ITEM_TYPE.Worm,ItemBase.ITEM_TYPE.Eye] : ItemBase.ITEM_TYPE.Spaghetti,
	[ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Water,ItemBase.ITEM_TYPE.Apple] : ItemBase.ITEM_TYPE.Croissant,
	[ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Water,ItemBase.ITEM_TYPE.Pumpkin] : ItemBase.ITEM_TYPE.Croissant,
	[ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Water,ItemBase.ITEM_TYPE.Mandrake] : ItemBase.ITEM_TYPE.Croissant,
	[ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Pumpkin] : ItemBase.ITEM_TYPE.Eclair,
	[ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Eye] : ItemBase.ITEM_TYPE.EyePie,
	[ItemBase.ITEM_TYPE.Bone,ItemBase.ITEM_TYPE.Mushroom,ItemBase.ITEM_TYPE.Mandrake] : ItemBase.ITEM_TYPE.DevilPie,
}

var fireworkScene = preload("res://particles/firework.tscn")

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

func update_glow(heldItem):
	if heldItem == null:
		$GPUParticles3D.emitting = false
	elif heldItem.isReagent:
		$GPUParticles3D.emitting = true
	else:
		$GPUParticles3D.emitting = false

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
	var firework = fireworkScene.instantiate()
	firework.global_position = $Output.global_position
	add_child(firework)
	firework.apply_central_impulse(Vector3(0,5,0).rotated(Vector3(0,1,0),randf()*2*PI))
	
	if itemMemory.size()>2:
		puke()
	pass

func puke():
	# some smart code for picking what item to make
	var result = ItemBase.ITEM_TYPE.Junk
	for R in validRecipies.keys():
		var testedRecipie = R.duplicate()
		for I in itemMemory:
			testedRecipie.erase(I)
		if testedRecipie.is_empty():
			result = validRecipies[R]
				
	itemMemory.clear()
	var resultItem = load("res://entities/items/item_base.tscn").instantiate() as RigidBody3D
	resultItem.type = result
	resultItem.isReagent = false
	resultItem.global_position = $Output.global_position
	get_tree().current_scene.add_child(resultItem)
	resultItem.apply_central_impulse(Vector3(7,0,0).rotated(Vector3(0,1,0),randf()*2*PI))
	pass



