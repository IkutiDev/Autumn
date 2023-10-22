extends CanvasLayer

@export var customers_done_label : Label
@export var customers_min : Label
@export var current_cycle_name : Label
@export var current_cycle_time : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_cycle_name.text = GameManager.current_day_cycle.cycle_name
	current_cycle_time.text = ("%02d" % (GameManager.current_day_cycle.cycleTimer.time_left/60.0)) + ":"+ "%02d" % (GameManager.current_day_cycle.cycleTimer.time_left as int % 60) 
	customers_done_label.text = str(GameManager.current_day_customers_done)
	customers_min.text = str(GameManager.customers_to_complete[GameManager.day_index])
