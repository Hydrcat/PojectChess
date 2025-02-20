class_name LevelInteract extends Node2D
## 交互层

enum InteractType {
	CLICK, # 点击
	DRAG, # 拖拽
}

# 拖拽阈值
const DRAG_THRESHOLD := 60

#-----------信号-----------#
signal map_clicked(pos:Vector2)
signal map_drag_begin(pos:Vector2)
signal map_drag_end(pos:Vector2)
signal map_dragging(pos:Vector2,relative:Vector2)
signal map_mouse_free_moving(pos:Vector2)

signal coord_clicked(coord:Vector2i)


#-----------交互-----------#
var is_pressed := false
var is_dragging := false
var drag_start : Vector2
var drag_offset : Vector2

## 处理交互
func _unhandled_input(event: InputEvent) -> void:
	##var mouse_pos := get_screen_transform().affine_inverse() * get_viewport().get_mouse_position()
	var mouse_pos := get_viewport().get_mouse_position()
	var mb := event as InputEventMouseButton
	if mb and mb.button_index == MOUSE_BUTTON_LEFT:
		is_pressed = mb.is_pressed()
		
		# 拖动时，记录拖动始的位置，并立即将其加入到待更新列表
		if is_pressed:
			drag_start = mouse_pos
		else :	
			if is_dragging:
				is_dragging = false
				_on_drag_end(mouse_pos)
			else :
				_on_pressed(mouse_pos)		
	
	var mm := event as InputEventMouseMotion
	if mm and not is_pressed:
		_on_mouse_free_move(mouse_pos)
		
	if mm and mm.button_mask & MOUSE_BUTTON_LEFT and is_pressed:
		if is_dragging:
			_on_dragging(mouse_pos,mm.relative)
		else :
			var distance = mouse_pos - drag_offset
			if distance.length() > DRAG_THRESHOLD:	
				is_dragging = true
				_on_drag_begin(mouse_pos)


	
#---------------- 鼠标交互回调 -------------------#

func _on_drag_begin(mouse_pos:Vector2):
	map_drag_begin.emit(mouse_pos)
	Log.info("drag begin:%s" % [mouse_pos])

func _on_drag_end(mouse_pos:Vector2):
	map_drag_end.emit(mouse_pos)	
	Log.info("drag end:%s" % [mouse_pos])

func _on_dragging(mouse_pos:Vector2,relative:Vector2):
	map_dragging.emit(mouse_pos,relative)
	Log.info("dragging:%s" % [mouse_pos])

func _on_pressed(mouse_pos:Vector2):
	var clicked_pos := to_global(mouse_pos)
	map_clicked.emit(clicked_pos)
	Log.info("clicked:%s" % [clicked_pos])

func _on_mouse_free_move(mouse_pos:Vector2):
	map_mouse_free_moving.emit(mouse_pos)
	#Log.info("mouse free moving:%s" % [mouse_pos])
