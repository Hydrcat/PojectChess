@tool
extends Node2D
class_name DebugLabel

@export var content:String:
	set(v):
		content = v
		await ready
		set_content(content)
		

func set_content(_content:String)->void:
	$Label.text = _content
