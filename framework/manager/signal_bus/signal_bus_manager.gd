extends ManagerBase
class_name SignalBusManager

# 玩家自定义信号总线初始化
func _enter_tree() -> void:
	init()
	pass

func init() -> void:
	var scripts := HydrcatFramework.asset_manager.load_group_asset("signal_bus") as Array[Resource]
	for script in scripts:
		var s := script as GDScript
		var signal_bus := s.new() as SignalBus
		signal_bus.name = s.get_global_name()
		add_child(signal_bus)
