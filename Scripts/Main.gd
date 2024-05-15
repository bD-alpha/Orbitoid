extends Node3D

var asteroid_small := preload("res://Scenes/Asteroid_Small.tscn")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	for i in 500:
		var asteroid := asteroid_small.instantiate()
		asteroid.position = Vector3.RIGHT.rotated(Vector3.UP, randf_range(0, TAU)) * randf_range(250, 350) + Vector3.UP * randf_range(-50, 50)
		asteroid.rotate_x(randf())
		asteroid.rotate_y(randf())
		asteroid.rotate_z(randf())
		add_child(asteroid)

