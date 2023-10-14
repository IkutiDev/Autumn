extends Node

signal movement(movement_vector)
signal interact()
signal drop()
signal select_left_item()
signal select_right_item()


var is_mouse_and_keyboard : bool

func _input(event):
	if (event is InputEventJoypadButton) or (get_joystick_movement_vector() != Vector2.ZERO):
		is_mouse_and_keyboard = false
	elif (event is InputEventKey) or (event is InputEventMouseButton) or (event is InputEventMouseMotion):
		is_mouse_and_keyboard = true
		
	if event.is_action_pressed("interact"):
		interact.emit()
		
	if event.is_action_pressed("drop"):
		drop.emit()
		
	if event.is_action_pressed("select_left_item"):
		select_left_item.emit()
	
	if event.is_action_pressed("select_right_item"):
		select_right_item.emit()

func _physics_process(delta):
	var movement_vector := get_movement_vector()
	
	movement.emit(movement_vector)
	
func get_movement_vector() -> Vector2:
	var movement_vector := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
	
	if movement_vector == Vector2.ZERO:
		movement_vector = get_joystick_movement_vector()
	
	return movement_vector

func get_joystick_movement_vector() -> Vector2:
	return Vector2(
		# As we're using an isometric view, with a 2:1 ratio, we have to double the horizontal input for horizontal movement to feel consistent.
		(Input.get_action_strength("move_right_joystick") - Input.get_action_strength("move_left_joystick")),
		Input.get_action_strength("move_down_joystick") - Input.get_action_strength("move_up_joystick")
		# We then normalize the vector to ensure it has a length of 1, making it a direction vector.
	).normalized()
