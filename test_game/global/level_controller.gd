extends Node
class_name LevelController

## 关卡控制器

## 当局中所有的角色
var roles: Array = []

## 当局中Entity的位置
var battle_map:Dictionary = {}

## 棋盘
@export var game_board: GameBoard = null
## 关卡状态
enum LevelState {
	INIT = 0, # 初始化
	PLAYING = 1, # 游戏中
	PAUSE = 2, # 暂停
	END = 3, # 结束
}

#region:战场
## Role相关的管理
func set_role_pos(role: ChessEntity, coord: Vector2i) -> void:
	role.coord = coord
	# 检查目标格子是否存在角色
	
	role.position = game_board.get_coord_pos(coord)

## 检查是否存在目标格子
func is_grid_exist(coord: Vector2i) -> bool:
	return game_board.is_grid_exist(coord)

## 检查目标单元格上是否存在单位
func is_role_exist(coord: Vector2i) -> bool:
	return game_board.is_role_exist(coord)
#endregion

#region:Role部分


## 角色预制体
var role_prefab: PackedScene = preload("res://test_game/entity/chess_entity.tscn")

## 构造角色，生成的角色此时还没有加入到场景中
func create_role(role_state_id: int) -> ChessEntity:
	var config := CfgTables.TbRoleStateConfig.get_item(role_state_id)
	var role: ChessEntity = role_prefab.instantiate()
	role.init_role(config)
	return role

## 角色出生
func role_born(role: ChessEntity, coord: Vector2i, camp: int) -> void:
	role.coord = coord
	role.camp = camp
	role.state = 1
	roles.append(role)
	add_child(role)
	
	set_role_pos(role, coord)
	

#endregion