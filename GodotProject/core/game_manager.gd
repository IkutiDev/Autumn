extends Node

@export var main_menu_scene : PackedScene
@export var gameplay_scene : PackedScene

func change_to_gameplay_scene() -> void:
	get_tree().change_scene_to_packed(gameplay_scene)

func change_to_main_menu_scene() -> void:
	get_tree().change_scene_to_packed(main_menu_scene)


func end_night():
	$Night._stop()
	pass

func _ready():
	$Afternoon._start()

# manage day cycle



# pick what NPCs to spawn

