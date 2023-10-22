extends Node

signal evening_starts()
signal night_summary()

@export var main_menu_scene : PackedScene
@export var game_over_scene : PackedScene
@export var gameplay_scene : PackedScene

@export var customers_to_complete : PackedInt32Array
@export var customers_to_spawn : Array[PackedScene]
@export var evening : DayCycle

var day_index := 0
var current_day_cycle : DayCycle

var current_day_customers_spawned := 0
var current_day_customers_done := 0
var total_customers_done := 0


func change_to_gameplay_scene() -> void:
	get_tree().change_scene_to_packed(gameplay_scene)
	$Afternoon._start()
	RecipeManager.item_type_unlocked(ItemBase.ITEM_TYPE.Apple)
	RecipeManager.item_type_unlocked(ItemBase.ITEM_TYPE.Water)
	RecipeManager.item_type_unlocked(ItemBase.ITEM_TYPE.Bone)

func change_to_main_menu_scene() -> void:
	get_tree().change_scene_to_packed(main_menu_scene)

func change_to_game_over_scene() -> void:
	current_day_customers_done = 0
	current_day_customers_spawned = 0
	get_tree().change_scene_to_packed(game_over_scene)

func end_night():
	if current_day_customers_done < customers_to_complete[day_index]:
		change_to_game_over_scene()
		return
	if customers_to_spawn.size() > day_index + 1:
		day_index += 1
		evening.howMuchLasts += 20
	current_day_customers_done = 0
	current_day_customers_spawned = 0
	$Night._stop()
	pass

#func _ready():
#	$Afternoon._start()


# manage day cycle



# pick what NPCs to spawn

