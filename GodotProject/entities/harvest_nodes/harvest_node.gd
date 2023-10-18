extends Node3D

@export_category("Grow Stats")
@export var can_grow := true
@export var grow_time := 5.0
@export var node_yield := 1
@export var node_life := -1
@export var item_to_spawn : PackedScene
@export var spawn_item_offset := Vector3(0,2,0)
@export_group("References")
@export var interaction_area : Area3D
@export var visual_mesh_instance : MeshInstance3D
@export var plant_mesh_instance : MeshInstance3D
@export var grow_time_label : Label3D
@export var animation_player : AnimationPlayer

var base_color : Color
var player : Player

var plantable := false
var harvestable := false
var is_growing := false
var current_node_life := 0

var growing_timer := 0.0

func _enter_tree():
	current_node_life = node_life

# Called when the node enters the scene tree for the first time.
func _ready():
	if not can_grow:
		harvestable = true
	if not is_growing and animation_player != null:	
		animation_player.stop()
	InputManager.interact.connect(interaction)
#	base_color = visual_mesh_instance.mesh.material.albedo_color
	interaction_area.body_entered.connect(select)
	interaction_area.body_exited.connect(deselect)

func _exit_tree():
	InputManager.interact.disconnect(interaction)
	interaction_area.body_entered.disconnect(select)
	interaction_area.body_exited.disconnect(deselect)


func select(body : Node3D):
	player = body as Player	
	if not is_growing and animation_player != null:	
		animation_player.play()
	
func deselect(body : Node3D):
	player = null	
	if not is_growing and animation_player != null:	
		animation_player.stop()

	
func _process(delta):
	if growing_timer > 0:
		grow_time_label.text = "Grow time:"+"%.2f" % (growing_timer)
		growing_timer -= delta
		if growing_timer <= 0:
			harvestable = true
			is_growing = false
	if can_grow:
		plant_mesh_instance.visible = harvestable
	
func interaction() -> void:
	
	if is_growing:
		return
	
	if not player:
		return
	
	if player.holding_hat.focusedEnitity != null or player.holding_hat.heldItem != null:
		return
	
	if can_grow:
		plantable = player.has_correct_plant_item
	
	if harvestable:
		for i in node_yield:
			var item_instance = item_to_spawn.instantiate() as ItemBase
			get_tree().root.add_child(item_instance)
			item_instance.global_position = player.global_position + spawn_item_offset
		print("Gain "+ str(node_yield)+" items")
		if can_grow:
			if current_node_life > 0:
				current_node_life -= 1
				harvestable = false
				if current_node_life > 0:
					start_growing(false)
			else:
				harvestable = false

	elif plantable and not is_growing:
		start_growing(true)


func start_growing(restart_node_life : bool) -> void:
	is_growing = true
#	visual_mesh_instance.mesh.material.albedo_color = Color("Red")
	growing_timer = grow_time
	if restart_node_life:
		current_node_life = node_life
