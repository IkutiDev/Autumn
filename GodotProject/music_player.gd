extends AudioStreamPlayer

@export var possible_trakcs : Array[AudioStream]
@export var silence_time := 5.0

var silence_timer := 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	play_another_track()
	finished.connect(end_track)

func _process(delta):
	if silence_timer > 0:
		silence_timer -= delta
		if silence_timer <= 0:
			play_another_track()

func play_another_track() -> void:
	stream = possible_trakcs[randi()%possible_trakcs.size()]
	play()

func end_track():
	silence_timer = silence_time
