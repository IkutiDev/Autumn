extends Path3D

signal moving_complete(item)

var movedItem = null

var moving
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move_item(item):
	if movedItem != null:
		return
	movedItem = item
	item.freeze = true
	curve.set_point_position(0,to_local(item.global_position))
	item.reparent($Grab,false)
	$Mover.play("MoveAnimation")
	pass


func _on_mover_animation_finished(anim_name):
	emit_signal("moving_complete",movedItem)
	movedItem = null
	pass # Replace with function body.
