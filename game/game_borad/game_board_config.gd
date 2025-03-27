@tool
extends Resource
class_name GameBoardConfig

# GameBoard配置
enum GridType {
	Empyty, # 空地格
	Block, # 障碍格
	
}
const ResourcePath = "res://config/game_boards/{0}.tres" # 资源路径


@export var grid_sets: Dictionary[Vector2i, GridType]  # 格子集合
@export var game_board_size: Rect2i # 游戏棋盘大小

static func save_config(config:GameBoardConfig,id: int) -> void:
	if ResourceSaver.save(config, ResourcePath.format([str(id)])) != OK:
		Log.error("保存配置失败")
		return
	Log.info("保存配置成功")

static func load_config(id: int) -> GameBoardConfig:
	var path = ResourcePath.format([str(id)])
	var res = ResourceLoader.load(path,"GameBoardConfig")
	if res == null:
		Log.error("加载配置失败")
		return
	Log.info("加载配置成功")
	return res as GameBoardConfig
