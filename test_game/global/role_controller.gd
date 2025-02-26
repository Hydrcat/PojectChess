extends Node
class_name RoleController	

## 角色管理器
signal role_borned(role:ChessEntity, coord:Vector2i, camp:int)

## 当局中所有的角色
var roles: Array = []

## 角色预制体
var role_prefab: PackedScene = preload("res://test_game/entity/chess_entity.tscn")

## 构造角色，生成的角色此时还没有加入到场景中
func create_role(role_state_id:int) -> ChessEntity:
	var config := CfgTables.TbRoleStateConfig.get_item(role_state_id)
	var role:ChessEntity = role_prefab.instantiate()
	role.init_role(config)
	return role

## 角色出生
func role_born(role:ChessEntity, coord:Vector2i, camp:int) -> void:
	role.coord = coord
	role.camp = camp
	role.state = 1
	roles.append(role)
	add_child(role)

	# 通知LevelController，设置角色的位置
	role_borned.emit(role, coord, camp)