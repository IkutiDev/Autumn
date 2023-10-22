extends Control

@export var customers_sated_label : Label

func _on_button_pressed():
	GameManager.change_to_main_menu_scene()


func _process(delta):
	customers_sated_label.text = str(GameManager.total_customers_done)
