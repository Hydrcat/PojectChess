extends GameSignalBusCustom
class_name GameSignalBus

# HydrcatFramework 自动生成
# 请勿修改

#region: 单例
static var instance: GameSignalBus

func _ready() -> void:
	assert(instance == null,"单例已存在:"+"GameSignalBus")
	instance = self
	
#endregion

#region: signal
signal game_over()
signal game_start()
#endregion