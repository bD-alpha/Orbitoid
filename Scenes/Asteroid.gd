@tool
extends StaticBody3D

@export_enum("None:0", "Ironum:1") var ore : int :
	set(value):
		ore = value
		await ready
		for i in ores.size():
			ores[i].visible = ore-1 == i

@onready var ores = [$Ironum]
