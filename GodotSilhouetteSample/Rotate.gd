extends Spatial


export var phase = 0.0

var time = 0.0

func _process(delta):
	time += delta
	translation = Vector3(4 * sin(phase + time * 2), 0.0, 2 * cos(phase + time * 2))
