@tool
class_name GameBoard extends Node2D

## 战旗游戏中的棋盘
## 处理棋盘的逻辑和显示

# 枚举
## 棋盘的状态
enum BoardState {
	NORMAL = 0, # 正常状态
}

# viusalGridTile
const GRID_TILE: PackedScene = preload("res://test_game/game_borad/grid_tile.tscn")

#region: debug
@export_category("Debug")
@export var is_debug_mode := false: # 是否是调试模式
	set(v):
		is_debug_mode = v
		if is_debug_mode:
			for child in get_children():
				if child is GridTile:
					child.show()
		else:
			for child in get_children():
				if child is GridTile:
					child.hide()

@export var coord_visual: bool = false # 是否显示坐标
#endregion


# 主要棋盘
@onready var main_board: TileMapLayer = $MainBorad
# 交互用棋盘
@onready var interact_board: TileMapLayer = $InteractBorad
# 交互用格子
@onready var grids: Node2D = $Grids

# 格子集合
var grid_tiles: Dictionary = {}

# 当前选中的格子
var selected_grid: GridTile = null


# 真实游戏中不启用
func _ready() -> void:
	
	if Engine.is_editor_hint():
		$MainBorad.enabled = false
		init_board_in_engine()
	else:
		main_board.enabled = false
		init_board()

## 初始化棋盘
func init_board() -> void:
	#FIXME：这里通过tileset简单的获得tile的位置，后期需要转换为正式配置
	var used_coords := main_board.get_used_cells()
	for coord in used_coords:
		var tile: GridTile = GRID_TILE.instantiate()
		tile.position = main_board.map_to_local(coord)
		tile.set_coord(coord)
		tile.name = "%d,%d" % [coord.x, coord.y]
		grid_tiles[coord] = tile
		grids.add_child(tile)

## 编辑器模式下
func init_board_in_engine() -> void:
	var used_coords: Array[Vector2i] = $MainBorad.get_used_cells()
	for coord in used_coords:
		var tile: GridTile = GRID_TILE.instantiate()
		tile.position = $MainBorad.map_to_local(coord)
		tile.set_coord(coord)
		tile.name = "%d,%d" % [coord.x, coord.y]
		grid_tiles[coord] = tile
		$Grids.add_child(tile)

# 处理点击，需要额外考虑相机的位置
func _on_map_clicked(pos: Vector2) -> void:
	var coord: Vector2i = main_board.local_to_map(pos)
	var clicked_grid: GridTile = grid_tiles[coord]
	if clicked_grid:
		if selected_grid:
			selected_grid.is_selcted = false
		selected_grid = clicked_grid
		clicked_grid.is_selcted = not clicked_grid.is_selcted

# 拖动方向
func _on_dragging(_pos: Vector2, relative: Vector2) -> void:
	GameSignalBus.instance.camera_move_to.emit(-relative)
	pass

#region:Utils

## 获得图的中心位置
func get_center_pos() -> Vector2:
	return main_board.map_to_local(main_board.get_used_rect().get_center())

## 获得指定的格子的位置
func get_coord_pos(coord:Vector2i) -> Vector2:
	return main_board.map_to_local(coord)

## 检查是否存在目标格子
func is_grid_exist(coord:Vector2i) -> bool:
	return grid_tiles.has(coord)

#endregion

#reigon:Entity

#endreigon