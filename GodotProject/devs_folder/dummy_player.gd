extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += Vector3(int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left")),0,int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up"))) * delta * 10


