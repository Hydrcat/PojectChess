@tool
class_name GameBoard extends Node2D

## 战旗游戏中的棋盘
## 处理棋盘的逻辑和显示

## debug 模式
@export_category("Debug")
@export var is_debug_mode := false # 是否是调试模式
@export var coord_visual: bool = false # 是否显示坐标

# viusal
const GRID_TILE: PackedScene = preload("res://game_borad/grid_tile.tscn")

# 子节点
@onready var main_board: TileMapLayer = $MainBorad

func generate_grid_tile():
	#FIXME：这里通过tileset简单的获得tile的位置，后期需要转换为正式配置
	var used_coords := main_board.get_used_cells()
	for coord in used_coords:
		var tile: Node2D = GRID_TILE.instantiate()
		tile.position = main_board.map_to_local(coord)
		tile.coord = coord
		add_child(tile)

func _ready():
	if is_debug_mode:
		generate_grid_tile()
