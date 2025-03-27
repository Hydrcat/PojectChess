class_name BattleGrid
extends Node2D

# 战场

signal unit_moved(unit: Unit, from: Vector2i, to: Vector2i)

# 战场层
@onready var game_board: TileMapLayer = $Logic/GameBorad
@onready var camera_2d: BattleCamera = $Camera2D

# 配置参数
@export var cell_size := Vector2i(164, 190)


func _ready() -> void:
	Interact.set_camera($Camera2D)
	Interact.click.connect(_on_click)


func _on_click(pos: Vector2) -> void:

	var cener_pos := camera_2d.get_screen_center_position()
	var coord := game_board.local_to_map(to_global(pos))
	
	Log.info("点击位置:{0},mouse_positon:{1}".format([coord,pos]))
