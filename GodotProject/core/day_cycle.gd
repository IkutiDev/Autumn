extends Node
class_name DayCycle

@export var cycle_name : String
@export var howMuchLasts : int

@onready var cycleTimer : Timer

@export var nextCycle : NodePath

func _ready():
	var newClock = Timer.new()
	newClock.one_shot = true
	newClock.wait_time = howMuchLasts
	newClock.connect("timeout",_stop)
	add_child(newClock)
	cycleTimer = newClock
	print(cycleTimer)

func _start():
	cycleTimer.start()
	GameManager.current_day_cycle = self
	start()
	pass


func _stop():
	stop()
	get_node(nextCycle)._start()
	pass
	

#this one you overide
func start():
	pass
func stop():
	pass
