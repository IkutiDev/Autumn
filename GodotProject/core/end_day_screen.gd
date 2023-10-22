extends CanvasLayer

func _ready():
	Engine.time_scale = 0


func _on_button_pressed():
	Engine.time_scale = 1
	GameManager.end_night()
	self.queue_free()
	pass # Replace with function body.
