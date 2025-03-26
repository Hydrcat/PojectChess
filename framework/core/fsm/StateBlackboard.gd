extends StateBase
class_name StateBlackboard
## 状态黑板，在各个状态间传输变量
var data: Dictionary = {}

func _enter_tree():
	# 状态机根节点的 blackboard 属性为自身
	get_parent().blackboard = self

func set_data(key: String, value: Variant) -> void:
	data[key] = value

func get_data(key: String) -> Variant:
	return data[key]
