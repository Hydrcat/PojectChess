extends PoolNodeComponent


## 唤醒时触发
func _on_awake() -> void:
	entity.born()
	

## 冻结时触发回调
func _on_sleep() -> void:
	pass

## 唤醒时，每一帧都会调用
func _update(_delta: float) -> void:
	entity.on_live(_delta)
