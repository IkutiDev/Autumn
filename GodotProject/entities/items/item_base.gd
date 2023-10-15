extends RigidBody3D

@onready var baseColor = $Sprite3D.modulate 

enum ITEM_TYPE {Herb, Pumpkin}

@export var type : ITEM_TYPE

@export var isReagent = true

func _ready():
	
	pass

func select_is_valid():
	return true

func select():
	$Sprite3D.modulate = Color("Pink")
	pass
	
func deselect():
	$Sprite3D.modulate = baseColor
	pass
