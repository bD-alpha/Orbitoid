extends CharacterBody3D

@export var speed : float

@onready var model := $Transtellar

var target_direction : Vector2 = Vector2.ZERO
var forward : Vector3 = Vector3.FORWARD
var right : Vector3 = Vector3.RIGHT

func _process(delta):	
	var new_forward : Vector3
	var new_right : Vector3
	
	new_forward = forward.rotated(right, -target_direction.y * delta).normalized()
	new_right = right.rotated(forward, target_direction.x * delta).normalized()
	
	forward = new_forward
	right = new_right
	
	target_direction *= 0.85
	
	look_at(position+forward, right.cross(forward))
	print(target_direction)

func _physics_process(delta):
	velocity = forward * speed
	move_and_slide()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		target_direction += event.relative * 0.02
