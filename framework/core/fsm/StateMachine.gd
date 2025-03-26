extends StateBase
class_name StateMachine
## 状态机
signal state_changed(last_state, current_state)

## 当前的状态
var current_state: String
## 当前的状态节点
var current_state_node: State
## 状态黑板
var blackboard: StateBlackboard
## 所有的状态节点
var states := {}

#-------------------------------------------------------
#	set/get
#-------------------------------------------------------
func get_state_node_list() -> Array:
	return states.values()

func get_blackboard() -> StateBlackboard:
	if blackboard == null:
		for child in self.get_children():
			if child is StateBlackboard:
				blackboard = child
	return blackboard

func get_state_node(state: String) -> State:
	return states[state]


#-------------------------------------------------------
#	内置
#-------------------------------------------------------
func _ready() -> void:
	#初始化状态机
	## 找到所有的子状态
	for child in self.get_children():
		if child is State:
			states[child.name] = child
		if child is StateBlackboard:
			blackboard = child
	if states.size() > 0:
		current_state = states.keys()[0]
		current_state_node = states[current_state]
		current_state_node._enter()
	else:
		set_physics_process(false)
		printerr("当前状态机不存在子状态，请检查")
		

func _physics_process(delta: float) -> void:
	current_state_node.state_process(delta)

#-------------------------------------------------------
#	自定义
#-------------------------------------------------------
func switch_to(state: String, data: Dictionary = {}) -> void:
	if state != current_state:
		current_state_node._exit()
		state_changed.emit(current_state, state)
		
		current_state = state
		current_state_node = states[current_state]
		current_state_node._enter(data)
