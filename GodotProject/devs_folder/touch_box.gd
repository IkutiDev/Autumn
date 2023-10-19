extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	for C in get_children(false):
		C.visible = false
	pass # Replace with function body.







func _on_body_exited(body):
	for C in get_children(false):
		C.visible = false
	pass # Replace with function body.


func _on_body_entered(body):
	for C in get_children(false):
		C.visible = true
	pass # Replace with function body.
