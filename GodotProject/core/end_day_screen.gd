extends CanvasLayer




func _on_button_pressed():
	GameManager.end_night()
	self.queue_free()
	pass # Replace with function body.
