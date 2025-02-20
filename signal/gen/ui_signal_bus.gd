extends UISignalBusCustom
class_name UISignalBus

# HydrcatFramework 自动生成
# 请勿修改

#region: 单例
static var instance: UISignalBus

func _ready() -> void:
	assert(instance == null,"单例已存在:"+"UISignalBus")
	instance = self
	
#endregion

#region: signal
signal test_signal()
#endregion