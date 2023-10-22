extends Node3D

signal remove_customer(customer)

@export var desiredItem : PackedScene

@export var broughtItem : PackedScene

var desiredItemNode

var broughtItemNode

@export var allItemsOffered : Array[PackedScene] = []

@export var allItemsWanted : Array[PackedScene] = []

@export_group("References")
@export var animation_player : AnimationPlayer
@export var desired_item_sprite : Sprite3D

var current_player : Player = null

func _ready():
	if desiredItem == null:
		if GameManager.current_day_customers_spawned <= 3:
			desiredItem = allItemsWanted[randi()%2]
		else:
			desiredItem = allItemsWanted[randi()%allItemsWanted.size()]
	if broughtItem == null:
		broughtItem = allItemsOffered[randi()%allItemsOffered.size()]

	desiredItemNode = desiredItem.instantiate()
	broughtItemNode = broughtItem.instantiate()
	print(desiredItemNode,broughtItemNode)
	broughtItemNode.freeze = true
	desiredItemNode.freeze = true
	#$DesiredItemPreview.add_child(desiredItemNode)
	desired_item_sprite.texture = desiredItemNode.item_image
	$OfferedItemPreview.add_child(broughtItemNode)
	
	InputManager.reject_customer.connect(reject_customer)


func update_animation(is_walking := false) -> void:
	if is_walking:
		animation_player.play("walk")
	else:
		animation_player.play("idle")


func give_gift():
	broughtItemNode.reparent(get_tree().current_scene)
	broughtItemNode.global_position = $ItemSpawnPoint.global_position
	broughtItemNode.freeze = false
	remove_customer.emit(self)
	GameManager.current_day_customers_done += 1
	GameManager.total_customers_done += 1
	#$AnimationPlayer.play("exit")
	pass


func _on_pickup_spot_body_entered(body):
	current_player = body
	var heldItem = get_tree().get_nodes_in_group("Hat")[0].get_held_item()
	if heldItem == null:
		return
	if heldItem.type == desiredItemNode.type:
		heldItem.queue_free()
		give_gift()
	pass # Replace with function body.


func _on_pickup_spot_body_exited(body):
	current_player = null

func reject_customer() -> void:
	if current_player == null:
		return
	remove_customer.emit(self)
