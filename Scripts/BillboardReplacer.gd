@tool
extends Sprite3D
class_name BillboardReplacer

@export var mesh : GeometryInstance3D
@export var distance : float
@export var transition : float

func _ready():
	rotation.z = randf() * TAU

func _process(delta):
	var camera : Camera3D = get_viewport().get_camera_3d()
	if not camera: return
	
	var dst := camera.global_position.distance_to(global_position)
	if dst > distance + transition:
		mesh.visible = false
		visible = true
	elif dst > distance:
		mesh.visible = true
		visible = true
		mesh.transparency = (dst - distance) / transition
		transparency = 1.0 - (dst - distance) / transition
	else:
		mesh.visible = true
		visible = false
