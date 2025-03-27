extends State

## 信号
signal click

## 鼠标左键按下的时间
const HOLD_TIME = 0.5

var is_holding := false
var holding_time: float = 0


#--------------------------------------#
# 自定义 区域
#--------------------------------------#

## 1.进入动作
func _enter(_data: Dictionary = {}) -> void:
	Mouse.switch_shape(Mouse.CURSOR_TYPE.NORMAL)
	is_holding = false
	holding_time = 0.0

## 2.离开动作	
func _exit() -> void:
	pass

## 3.输入动作
func state_process(_delta: float) -> void:
	if is_holding:
		holding_time += _delta
		if holding_time >= HOLD_TIME:
			switch_to("Drag")
	else:
		holding_time = 0.0

## 4.转移动作
func switch_to(next_state: String, data: Dictionary = {}) -> void:
	return state_machine.switch_to(next_state, data)

## 5.输入事件
func _state_unhandled_input(event: InputEvent) -> void:
	# 如果长按鼠标左键，进入拖拽状态
	if event.is_action_pressed("click"):
		is_holding = true

	if event.is_action_released("click"):
		is_holding = false

		## 视作发生了一次点击
		click.emit()
		Log.info("click veiw pos:" + str(event.position))
