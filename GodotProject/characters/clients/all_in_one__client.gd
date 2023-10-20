extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var allVersions = $Armature/Skeleton3D.get_children()
	for i in allVersions:
		i.visible = false
	allVersions[randi()%allVersions.size()].visible = true
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
