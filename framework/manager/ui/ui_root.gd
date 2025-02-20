extends CanvasLayer
class_name UIRoot
## ui的根节点
## 负责确定锚点位置，每个节点树只能同时存在一个ui_root


func _ready() -> void:
	HydrcatFramework.ui_manager.ui_root = self
	
	# 遍历子节点，将所有的panel注册给ui_manager
	for child in get_children():
		if child is UIPanel:
			HydrcatFramework.ui_manager.register_panel(child)
