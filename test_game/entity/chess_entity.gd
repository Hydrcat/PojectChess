class_name ChessEntity extends Area2D

## 棋子的类

## 棋子状态
var state:int = 0

## 坐标
var coord:Vector2i = Vector2i(0,0)

## 阵营
var camp:int = 0

## entity_state
var role_state_config:RoleStateConfig = null
var role_state:RoleState = null

func init_role(_role_state_config:RoleStateConfig) -> void:
    role_state_config = _role_state_config

    await ready
    role_state.max_hp = role_state_config.max_hp
    role_state.max_ap = role_state_config.max_ap
    role_state.atk = role_state_config.atk
