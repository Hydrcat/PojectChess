extends Node2D


@export var prefab :PackedScene

func _ready() -> void:
	var test := prefab.instantiate()
	add_child(test)
	
	
