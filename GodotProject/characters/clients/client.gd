extends Node3D

var desiredItemType

var offeredItemType

var itemBaseScene = preload("res://entities/items/item_base.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func give_gift():
	
	pass


func _on_pickup_spot_body_entered(body):
	if get_tree().get_nodes_in_group("Hat")[0].get_held_item().type == desiredItemType:
		give_gift()
	pass # Replace with function body.
