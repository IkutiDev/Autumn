extends Control


func _on_play_button_pressed():
	GameManager.change_to_gameplay_scene()


func _on_exit_button_pressed():
	get_tree().quit()
