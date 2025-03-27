extends StateMachine

# 在指定位置发生一次点击
signal click(pos:Vector2) 

# 交互管理
const INTERACT_MODE = {
	CLICK = "Click", # 点击模式
	SELECT = "Select", # 选择模式
	DISABLE = "Disable", # 禁用
}

func _state_machine_ready() -> void:
	get_state_node("Click").click.connect(on_click)
	pass

# 设置相机
func set_camera(camera: BattleCamera) -> void:
	blackboard.set_data("camera", camera)

# 交互覆写
func _unhandled_input(event: InputEvent) -> void:
	if current_state_node is State:
		current_state_node._state_unhandled_input(event)

## 点击指定的区域，只处理场景里的点击
func on_click() -> void:
	var mouse_global_pos = Mouse.get_mouse_position()
	click.emit(mouse_global_pos)
