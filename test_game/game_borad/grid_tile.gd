@tool
class_name GridTile extends Node2D

enum VisualState{
	NORMAL = 0,
	DANGER = 1,
}

@onready var select_visual = get_node("Select")
@onready var danger_visual = get_node("GridVisual/Danger")

## 格子的当前状态
@export var state:VisualState = VisualState.NORMAL:
	set(v):
		state = v
		on_state_change()
## 格子是否被选中
@export var is_selcted :bool = false:
	set(v):
		is_selcted = v
		if is_selcted:
			select_visual.show()
		else:
			select_visual.hide()
		
func on_state_change()->void:
	match state:
		VisualState.NORMAL:
			danger_visual.hide()
		VisualState.DANGER:
			danger_visual.show()

## 显示的坐标
var coord :Vector2i = Vector2i.ZERO

# func _enter_tree() -> void:
# 	var coord_label := Label.new()
# 	coord_label.text = "(%d,%d)" % [coord.x,coord.y]
# 	add_child(coord_label)

func set_coord(coord:Vector2i)->void:
	self.coord = coord
	$DebugLabel.text = "(%d,%d)" % [coord.x,coord.y]

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	var tween:Tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"scale",Vector2(1,1),0.5).from(Vector2(0,0))
