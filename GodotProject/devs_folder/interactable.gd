extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	deselect()
	pass # Replace with function body.

func select_is_valid():
	return true

func select():
	$MeshInstance3D.mesh.material.albedo_color = Color("Pink")
	pass
	
func deselect():
	$MeshInstance3D.mesh.material.albedo_color = Color("White")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
