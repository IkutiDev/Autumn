extends AudioStreamPlayer3D

@export var playedTracks : Array[Resource]

@export var pitchScaleRange = 0.5

@onready var basePitch = pitch_scale

func _ready():
	jiggle()

func jiggle():
	pitch_scale = basePitch + randf() * pitchScaleRange
	stream = playedTracks[randi()%playedTracks.size()]

func _on_finished():
	jiggle()
	pass # Replace with function body.
