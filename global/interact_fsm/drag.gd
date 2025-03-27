extends State

#--------------------------------------#
# 自定义 区域
#--------------------------------------#
var drag_start_pos: Vector2
var camera: Camera2D

## 1.进入动作
func _enter(_data: Dictionary = {}) -> void:
	Mouse.switch_shape(Mouse.CURSOR_TYPE.DRAG)
	
	camera = get_blackboard().get_data("camera")

	# 记录拖拽开始的位置
	drag_start_pos = camera.global_position

## 2.离开动作	
func _exit() -> void:
	pass

## 3.输入动作
func state_process(_delta: float) -> void:
	pass

## 4.转移动作
func switch_to(next_state: String, data: Dictionary = {}) -> void:
	return state_machine.switch_to(next_state, data)

func _state_unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("click"):
		switch_to("Click")

	if event is InputEventMouseMotion :
		camera.position += event.relative * -1