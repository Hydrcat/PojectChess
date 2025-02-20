extends StateBase
class_name State
## 状态节点

@onready var state_machine := self.get_parent() as StateMachine
	
#--------------------------------------#
##set get 区域
#--------------------------------------#

func get_state_machine():
	return state_machine as StateMachine

func get_current_state() -> State:
	return state_machine.get_current_state()

func get_blackboard() -> StateBlackboard:
	return state_machine.get_blackboard() 


#--------------------------------------#
# 自定义 区域
#--------------------------------------#

## 1.进入动作
func _enter(_data:Dictionary = {})->void:
	pass

## 2.离开动作	
func _exit()->void:
	pass	

## 3.输入动作
func state_process(_delta:float)->void:
	pass

## 4.转移动作
func switch_to(next_state:String,data:Dictionary={}) -> void:
	return state_machine.switch_to(next_state,data)
