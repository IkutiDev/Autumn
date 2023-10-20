class_name ItemBase
extends RigidBody3D

enum ITEM_TYPE {Apple, Pumpkin, Mandrake, Mushroom, Water, Bone, Worm,Eye,
Muffin, Eclair, BadApple, DevilPie, EyePie, Spaghetti, Croissant, MushroomJelly,
Junk}

@export var type : ITEM_TYPE

@export var isReagent = true

@export_group("References")
@export var item_label : Label3D

@export var itemScenes : Array[PackedScene] = []

#var typeToImageMap = {
#	0:load("res://entities/items/apple-seeds.png"),
#	1:load("res://entities/items/pumpkin.png"),
#	2:load("res://entities/items/tree-face.png"),
#	3:load("res://entities/items/mushroom-gills.png"),
#	4:load("res://entities/items/flowers.png"),
#	5:load("res://entities/items/pie-slice.png"),
#	6:load("res://entities/items/cake-slice.png"),
#	7:load("res://entities/items/apple-core.png"),
#	8:load("res://entities/items/cracked-glass.png")
#}

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
	item_label.text = str(ITEM_TYPE.keys()[type])
#	$Sprite3D.texture = typeToImageMap[type]
	pass

func select_is_valid():
	if get_parent().is_class("Marker3D"):
		return false
	return true

func select():
	$SelectionBox.visible = true
	pass
	
func deselect():
	$SelectionBox.visible = false
	pass
	
func update_glow(heldItem):
	if get_parent().is_class("Marker3D"):
		$Highlight.emitting = false
	else:
		$Highlight.emitting = true
	pass


func _on_body_entered(body):
	if !$Drop.playing:
		$Drop.pitch_scale = 1.2 + randf()*0.5
		$Drop.stream = load("res://SFX/body fall "+str(5+randi()%2)+".wav")
		$Drop.play()
	pass # Replace with function body.
