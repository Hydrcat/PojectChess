class_name GridTile extends Node2D


@onready var coord_label: Label = $CoordLabel

var coord :Vector2 = Vector2(0,0):
	set(v):
		await ready
		coord = v
		coord_label.text = "(%d,%d)" % [v.x,v.y]
