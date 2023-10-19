extends Node3D

@export var desiredItemType = 0

@export var offeredItemType = 6

var itemBaseScene = preload("res://entities/items/item_base.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func give_gift():

	var giftItem = itemBaseScene.instantiate()as RigidBody3D
	giftItem.type = offeredItemType
	giftItem.isReagent = false
	giftItem.global_position = $ItemSpawnPoint.global_position
	get_tree().current_scene.add_child(giftItem)
	$AnimationPlayer.play("exit")
	pass


func _on_pickup_spot_body_entered(body):
	if get_tree().get_nodes_in_group("Hat")[0].get_held_item().type == desiredItemType:
		give_gift()
	pass # Replace with function body.
