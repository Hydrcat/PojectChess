class_name BattleGrid
extends Node2D


signal cell_clicked(grid_pos: Vector2i)
signal unit_moved(unit: Unit, from: Vector2i, to: Vector2i)

# 配置参数
@export var cell_size := Vector2i(164, 190)

@onready var game_board := $GameBoard

