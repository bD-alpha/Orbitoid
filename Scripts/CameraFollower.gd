extends Node3D

@export var target : Node3D

func _process(delta):
	position = position.lerp(target.position, 0.25)
	rotation.x = lerp_angle(rotation.x, target.rotation.x, 0.25);
	rotation.y = lerp_angle(rotation.y, target.rotation.y, 0.25);
	rotation.z = lerp_angle(rotation.z, target.rotation.z, 0.25);
