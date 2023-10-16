extends Node3D

var itemScene = preload("res://entities/items/item_base.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func spawn_new_item(ID):
	var newItem = itemScene.instantiate()
	newItem.type = ID
	get_parent().add_child(newItem)
	return newItem
	pass



func _on_apple_spawner_body_entered(body):
	spawn_new_item(0).global_position = body.global_position + Vector3(0,2,0)
	pass # Replace with function body.


func _on_mushroom_spawner_body_entered(body):
	spawn_new_item(3).global_position = body.global_position + Vector3(0,2,0)
	pass # Replace with function body.


func _on_mandrake_spawner_body_entered(body):
	spawn_new_item(2).global_position = body.global_position + Vector3(0,2,0)
	pass # Replace with function body.


func _on_flower_spawner_body_entered(body):
	spawn_new_item(4).global_position = body.global_position + Vector3(0,2,0)
	pass # Replace with function body.


func _on_pumpkin_spawner_body_entered(body):
	spawn_new_item(1).global_position = body.global_position + Vector3(0,2,0)
	pass # Replace with function body.
