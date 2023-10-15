extends RigidBody3D

func _ready():
	
	pass

func select_is_valid():
	return true

func select():
	$Sprite3D.modulate = Color("Pink")
	pass
	
func deselect():
	$Sprite3D.modulate = Color("White")
	pass
