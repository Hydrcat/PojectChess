extends Node
class_name Utils
## 静态方法

## 获取某个节点的脚本类型
static func get_type_name(node: Node) -> StringName:
	var type_name: StringName = node.get_script().get_global_name()
	if type_name.is_empty():
		type_name = node.get_script().get_base_script().get_global_name()
	Log.info("node type :{node_type}",{node_type=type_name})
	return type_name
