## 框架入口
extends ManagerBase

@export_category("设置")
@export var need_gen:NeedGenHelper
@export_category("管理器")
@export var asset_manager: AssetManager
@export var ui_manager: UIManager
@export var pool_manager: PoolManager
@export var signal_bus_manager: SignalBusManager


## 注册指定的管理器
func register_manager()->void:
	pass
	
## 取消指定的管理器
func unregister_manager()->void:
	pass
