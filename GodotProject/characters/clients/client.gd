extends Node3D


@export var desiredItem : PackedScene

@export var broughtItem : PackedScene

var desiredItemNode

var broughtItemNode

@export var allItemsOffered : Array[PackedScene] = []

@export var allItemsWanted : Array[PackedScene] = []


func _ready():
	if desiredItem == null:
		desiredItem = allItemsWanted[randi()%allItemsWanted.size()]
	if broughtItem == null:
		broughtItem = allItemsOffered[randi()%allItemsOffered.size()]
	print(desiredItem,broughtItem)
	desiredItemNode = desiredItem.instantiate()
	broughtItemNode = broughtItem.instantiate()





func give_gift():
	broughtItemNode.global_position = $ItemSpawnPoint.global_position
	get_tree().current_scene.add_child(broughtItemNode)
	$AnimationPlayer.play("exit")
	pass


func _on_pickup_spot_body_entered(body):
	var heldItem = get_tree().get_nodes_in_group("Hat")[0].get_held_item()
	if heldItem == null:
		return
	if heldItem.type == desiredItemNode.type:
		heldItem.queue_free()
		give_gift()
	pass # Replace with function body.
