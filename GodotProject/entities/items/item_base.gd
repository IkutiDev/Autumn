extends RigidBody3D

@onready var baseColor = typeToColorMap[type]

enum ITEM_TYPE {Apple, Pumpkin, Mandrake, Mushroom, Flower, Pie, Cake, BadApple, Junk}

@export var type : ITEM_TYPE

@export var isReagent = true

var typeToImageMap = {
	0:load("res://entities/items/apple-seeds.png"),
	1:load("res://entities/items/pumpkin.png"),
	2:load("res://entities/items/tree-face.png"),
	3:load("res://entities/items/mushroom-gills.png"),
	4:load("res://entities/items/flowers.png"),
	5:load("res://entities/items/pie-slice.png"),
	6:load("res://entities/items/cake-slice.png"),
	7:load("res://entities/items/apple-core.png"),
	8:load("res://icon.png")
}

var typeToColorMap = {
	0:Color("Red"),
	1:Color("Orange"),
	2:Color("DarkGray"),
	3:Color("DarkGray"),
	4:Color("LightBlue"),
	5:Color("Orange"),
	6:Color("Green"),
	7:Color("Green"),
	8:Color("White")
}


func _ready():
	$Sprite3D.texture = typeToImageMap[type]
	pass

func select_is_valid():
	if get_parent().is_class("Marker3D"):
		return false
	return true

func select():
	$Sprite3D.modulate = Color("Pink")
	pass
	
func deselect():
	$Sprite3D.modulate = baseColor
	pass
	
func update_glow(heldItem):
	if get_parent().is_class("Marker3D"):
		$GPUParticles3D.visible = false
	else:
		$GPUParticles3D.visible = true
	pass
