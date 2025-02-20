extends ManagerBase
class_name PoolManager

var pools: Dictionary = {}

## 注册对象池
func register_pool(pool_name: StringName, node_prefab: PackedScene = null,
		defalut_node_amount: int = 10) -> NodePool:

	if self.pools.has(name):
		printerr("对象池已经存在")
	
	var temp_pool = NodePool.new()
	add_child(temp_pool)

	if node_prefab and defalut_node_amount:
		temp_pool.pool_node_prefab = node_prefab
		temp_pool.pool_size = defalut_node_amount
		temp_pool.initialize_pool(node_prefab)

	self.pools[pool_name] = temp_pool
	return temp_pool


## 获取对象池
func get_pool(pool_name: String) -> NodePool:
	if !self.pools.has(pool_name):
		printerr("对象池不存在")
		return null
	
	return self.pool[name]

## 销毁对象池
func unregister_pool(pool_name: StringName) -> void:
	var pool := get_pool(pool_name)
	
	pass
