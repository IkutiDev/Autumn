extends StaticBody3D

var eating = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func select_is_valid():
	return !eating

func select():
	$MeshInstance3D3.visible = true
	pass
	
func deselect():
	$MeshInstance3D3.visible = false
	pass

func om_nom_nom(item:RigidBody3D):
	
	item.freeze = true
	item.reparent($ItemHolder/Slot1,false)
	item.set_deferred("position",Vector3.ZERO)
	#create a path between the item and the pot and move the item along the path
	pass

func consume():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mover_animation_finished(anim_name):
	
	pass # Replace with function body.
