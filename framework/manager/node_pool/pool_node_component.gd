## 给希望入池的节点挂上该节点即可
extends ComponentBase
class_name PoolNodeComponent

## 可入池的对象的组件
var alive: bool = false;
var _pool: NodePool = null;

## register_pool
func register_pool(pool: NodePool) -> void:
	_pool = pool

## 冻结自身，_update方法不再进行
func sleep() -> void:
	_on_sleep()
	alive = false

## 唤醒时触发
func _on_awake() -> void:
	pass

## 冻结时触发回调
func _on_sleep() -> void:
	pass

## 唤醒时，每一帧都会调用
func _update(_delta: float) -> void:
	pass
