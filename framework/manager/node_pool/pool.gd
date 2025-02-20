## 节点池，类对象池 [br]
## 用于大量同类对象出现时使用
extends Node2D
class_name NodePool

var nodes: Array[Node] = []
var node_components: Array[PoolNodeComponent] = []
var node_type: String = ""

var _is_initialized := false


@export var pool_size := 100
@export var update_every_frame := true
@export var pool_node_prefab: PackedScene

signal pool_initialized

## 根据指定的类型初始化对象池,并根据池子的大小初始化一定数量的pool_object
func initialize_pool(_pool_object_prefab: PackedScene = null) -> void:
	if _pool_object_prefab:
		pool_node_prefab = _pool_object_prefab
	if pool_node_prefab == null:
		printerr("pool_node_prefab is null")
		return
	var test_node := pool_node_prefab.instantiate()
	test_node.queue_free()

	apply_more_node(pool_size)
	pool_initialized.emit()

## 从对象池中取出待唤醒的对象，同时触发其_on_awake()回调。	
func awake_object() -> Node:
	if nodes.size() == 0:
		return null
	
	var new_node: Node = null
	for node in nodes:
		if !ComponentBase.get_component(node, "PoolNodeComponent").alive:
			new_node = node
			break
	
	if !new_node:
		apply_more_node(pool_size)
		for node in nodes:
			if !ComponentBase.get_component(node, "PoolNodeComponent").alive:
				new_node = node
				break
		
	ComponentBase.get_component(new_node, "PoolNodeComponent").alive = true
	ComponentBase.get_component(new_node, "PoolNodeComponent")._on_awake()
	
	return new_node

## 冻结所有的对象
func sleep_all() -> void:
	for node in nodes:
		sleep_node(node)

## 冻结指定的对象
func sleep_node(node: Node) -> void:
	var pn: PoolNodeComponent = ComponentBase.get_component(node, "PoolNodeComponent")
	pn.sleep()

## 申请更多的node
func apply_more_node(amount: int) -> void:
	for i in range(amount):
		var temp := pool_node_prefab.instantiate()
		add_child(temp)

		var pn: PoolNodeComponent = ComponentBase.get_component(temp, "PoolNodeComponent")
		pn.register_pool(self)
		nodes.append(temp)
		node_components.append(pn)
	pool_initialized.emit()

func _ready() -> void:
	pool_initialized.connect(func() -> void:
		_is_initialized = true
		print("pool initialized")
	)

func _process(delta: float) -> void:
	for pn in node_components:
		if pn.alive:
			pn._update(delta)
		
	if update_every_frame:
		queue_redraw()
