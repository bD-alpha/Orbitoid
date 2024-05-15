extends GPUParticles3D


func _process(delta):
	position.x = get_parent().velocity.length()
