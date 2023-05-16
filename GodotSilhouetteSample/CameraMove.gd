extends Camera

var time = 0.0
var initial_translation: Vector3

func _ready():
	initial_translation = translation

func _process(delta):
	time += delta
	translation = initial_translation + Vector3.RIGHT * 0.25 * sin(time * 1.5)
