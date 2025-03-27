extends Node

const DEBUG_LABEL:= preload("res://global/debug/label/debug_label.tscn")

## 显示战场坐标
func show_coord_label() -> void:

	pass
	
## 在指定位置创建debug_label
static func create_debug_label(content:String, global_pos:Vector2,parent_node:Node) -> void:
	var prefab := DEBUG_LABEL.instantiate()
	prefab.content = content
	prefab.global_position = global_pos
	parent_node.add_child(prefab)
	
