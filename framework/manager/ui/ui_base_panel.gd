extends Control
class_name UIPanel
'''
UIPanel UI框架基础的组成单元
'''

## 父Panel
@export var parent_panel: StringName = "root"

## 父节点位置,相对父Panel的节点位置
@export var parent_node_path: StringName = "."

var UI: UIStatic

## Panel的初始化
func init() -> void:
	pass

#region:回调区
func _on_show() -> void:
	pass

func _on_hide() -> void:
	pass

#endregion

## panel的显示
func panel_show() -> void:
	show()
	
## panel的隐藏
func panel_hide() -> void:
	hide()

## panel的销毁
func panel_destroy() -> void:
	queue_free()

#region:功能区
func switch_to(panel: StringName) -> void:
	HydrcatFramework.ui_manager.open_panel(panel)
	HydrcatFramework.ui_manager.close_panel(self.name)

func open_panel(panel: StringName) -> void:
	HydrcatFramework.ui_manager.open_panel(panel)

func close_panel(panel: StringName) -> void:
	HydrcatFramework.ui_manager.close_panel(panel)
#endregion
