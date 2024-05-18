extends CharacterBody3D

@export var top_speed : float
@export var maneurity : float

@onready var model := $Mesh

var target_direction : Vector2 = Vector2.ZERO
var barrel := 0
var free_view := false
var autopilot := false

var forward : Vector3 = Vector3.FORWARD
var right : Vector3 = Vector3.RIGHT
var speed := 0.8

func _process(delta):	
	var new_forward : Vector3
	var new_right : Vector3
	var up := forward.cross(right).normalized()
	
	new_forward = forward.rotated(right, -target_direction.y * delta * maneurity).rotated(up, target_direction.x * delta * maneurity).normalized()
	new_right = right.rotated(up, target_direction.x * delta * maneurity).rotated(forward, barrel * delta * maneurity).normalized()
	
	forward = new_forward
	right = new_right
	
	target_direction *= 0.85
	
	look_at(position+forward, right.cross(forward))

func _physics_process(delta):
	velocity = forward * speed * top_speed
	move_and_slide()

func _unhandled_input(event):
	if event is InputEventMouseMotion and not (free_view or autopilot):
		target_direction += event.relative * 0.02
		target_direction = target_direction.limit_length(1)
	
	else:
		if event.is_action("Thurst (Up)"):
			speed = minf(1.0, speed + 0.01)
		elif event.is_action("Thurst (Down)"):
			speed = maxf(0.0, speed - 0.01)
		elif event.is_action_pressed("Free view"):
			free_view = true
		elif event.is_action_released("Free view"):
			free_view = false
		else:
			if not (free_view or autopilot):
				if event.is_action_pressed("Barrel left"):
					barrel -= 1
				elif event.is_action_pressed("Barrel right"):
					barrel += 1
				
				elif event.is_action_released("Barrel left"):
					barrel += 1
				elif event.is_action_released("Barrel right"):
					barrel -= 1
