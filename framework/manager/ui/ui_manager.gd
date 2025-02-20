extends ManagerBase
class_name UIManager
## UI管理器

## ui_signal_bus ,所有ui的信号默认走此
@export var ui_signal_helper: SignalHelper

## UIPanel的容器
var panel_dict: Dictionary

## 根节点,会在根节点初始化的时候告知管理器
var ui_root: UIRoot


func _ready() -> void:
	init()

## 初始化
func init() -> void:
	panel_dict = {}

## 注册Panel
func register_panel(panel:UIPanel)->void:
	panel_dict[panel.name] = panel


## 打开指定的UIPanel [br]
## 如果UIpanel不在节点树中，则从文件系统中实例化出对象。
func open_panel(panel_name: StringName) -> UIPanel:
	if panel_dict.has(panel_name):
		var panel: UIPanel = panel_dict[panel_name]
		panel.panel_show()
		return panel
		
	else:
		## panel不存在，则尝试加载
		var packed_scene := HydrcatFramework.asset_manager.load_asset("ui", panel_name.to_snake_case()) as PackedScene
		var panel_instance := packed_scene.instantiate() as UIPanel
		if panel_instance == null:
			Log.info("UIPanel加载失败:{panel_name}".format({"panel_name": panel_name}))
			return
		panel_instance.init()
		
		var parent_panel_name := panel_instance.parent_panel
		var parent_node_path := NodePath(panel_instance.parent_node_path)
		var parent_node :Node
		if parent_panel_name == &"root":
			parent_node = ui_root.get_node(parent_node_path)
		else :
			var parent_panel := open_panel(parent_panel_name)
			parent_node = parent_panel.get_node(parent_node_path)
		assert(parent_node != null, "父节点不存在")
		parent_node.add_child(panel_instance)
		
		register_panel(panel_instance)
		return panel_instance

## 关闭指定的UIPanel
func close_panel(panel_name: StringName) -> void:
	if panel_dict.has(panel_name):
		var panel: UIPanel = panel_dict[panel_name]
		panel.panel_hide()
	else:
		Log.info("UIPanel不存在:{panel_name}".format({"panel_name": panel_name}))
