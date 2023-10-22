extends CanvasLayer

@export var customers_sated_number : Label

func _ready():
	Engine.time_scale = 0


func _on_button_pressed():
	Engine.time_scale = 1
	GameManager.end_night()
	self.queue_free()
	pass # Replace with function body.

func _process(delta):
	customers_sated_number.text = str(GameManager.current_day_customers_done)
