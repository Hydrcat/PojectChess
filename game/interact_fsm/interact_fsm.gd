extends StateMachine
class_name InteractSystem

# 交互管理
const INTERACT_MODE = {
    CLICK = "Click", # 点击模式
    SELECT = "Select", # 选择模式
    DISABLE = "Disable", # 禁用
}

@export var camera:Camera2D

func _ready() -> void:
    super._ready()
    blackboard.set_data("camera", camera)

# 交互覆写
func _unhandled_input(event: InputEvent) -> void:
    if current_state_node is State:
        current_state_node._state_unhandled_input(event)