extends Node3D
var asteroid_small := preload("res://Scenes/Asteroid_Small.tscn")
var asteroid_medium := preload("res://Scenes/Asteroid_Medium.tscn")
var asteroid_big := preload("res://Scenes/Asteroid_Big.tscn")
var asteroids := [asteroid_small, asteroid_medium, asteroid_big]

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	for i in 500:
		var asteroid = asteroids.pick_random().instantiate()
		if randi_range(0, 100) < 15:
			asteroid.ore = 1
			
		asteroid.position = Vector3.RIGHT.rotated(Vector3.UP, randf_range(0, TAU)) * randf_range(150, 500) + Vector3.UP * randf_range(-75, 75)
		asteroid.rotate_x(randf())
		asteroid.rotate_y(randf())
		asteroid.rotate_z(randf())
		add_child(asteroid)
		
func _process(delta):
	pass

