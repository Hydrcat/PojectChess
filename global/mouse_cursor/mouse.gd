extends Node2D

@onready var mouse_sprite: Sprite2D = $Body/Visual
@onready var mouse_body: Node2D = $Body

@export_category("鼠标形态字典")
@export var mouse_shape_dict: Dictionary[CURSOR_TYPE, Texture2D] = {}

enum CURSOR_TYPE {
	NORMAL, # 正常鼠标
	DRAG, # 拖拽鼠标
	CLICK, # 点击鼠标
}

const mouse_speed: float = 60
var current_shape_type: CURSOR_TYPE

## cursor 是否可移动
var is_movable: bool
var tween: Tween

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN 
	is_movable = true
	switch_shape(CURSOR_TYPE.NORMAL)


func _input(event: InputEvent):
	var mouse_motion := event as InputEventMouseMotion
	var mouse_postion := get_viewport().get_mouse_position()

	if mouse_motion and is_movable:
		mouse_body.global_position = mouse_postion

#region:utils
## 获取鼠标位置
func get_mouse_position() -> Vector2:
	return mouse_body.global_position

func set_mouse_visible(switch: bool) -> void:
	mouse_sprite.visible = switch

func set_movable(switch: bool) -> void:
	is_movable = switch
	if switch:
		mouse_body.velocity = Vector2.ZERO

## 切换鼠标形态
func switch_shape(type: CURSOR_TYPE) -> void:
	var shape = mouse_shape_dict[type]
	if shape:
		mouse_sprite.texture = shape
		current_shape_type = type

#endregion
