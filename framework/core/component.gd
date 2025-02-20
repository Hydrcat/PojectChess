extends Node
class_name ComponentBase

## 组件的基类
# 为指定的节点添加组件时，会在其meta中添加组件的实例
# 一个节点，只能有一个同类组件。
# 暂时不考虑动态组件的情况

## 组件的生效对象
var entity: Node
## 组件管理器
var manager: Node
## 是否启用
var is_active: bool = true

## 获得指定单位上的组件
static func get_component(node: Node, component_type: StringName) -> ComponentBase:
	if node.has_meta(component_type):
		return node.get_meta(component_type)
	else:
		return null

## 注册组件
static func register_component(node: Node, component: ComponentBase) -> void:
	if node.has_meta(Utils.get_type_name(component)):
		printerr("组件已经存在")

	node.set_meta(Utils.get_type_name(component), component)

func _enter_tree() -> void:
	# 节点准备
	entity = get_parent()
	register_component(entity, self)

## 组件准备好
func _component_ready() -> void:
	# 组件准备
	pass
