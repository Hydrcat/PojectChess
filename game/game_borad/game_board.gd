@tool
extends HexagonTileMapLayer
class_name GameBoard
# GameBoard类

@export var game_board_config: GameBoardConfig:
	set(v):
		_try_load_config(v)
		game_board_config = v
		
		

# debug
@export var config_id: int = -1
@export_tool_button("保存配置", "Callable") var save_action = _save_config
@export_category("配置")
@export_tool_button("加载配置", "Callable") var load_action = _load_config

@onready var debug_sets: Node2D = $"../../Logic/Debug"
const DEBUG_LABEL:= preload("res://global/debug/label/debug_label.tscn")

func _ready():
	super._ready()
	# Enable pathfinding
	pathfinding_enabled = true

	# Customize pathfinding weights (optional)
func _pathfinding_get_tile_weight(coords: Vector2i) -> float:
	# Return custom weight value (default is 1.0)
	return 1.0

	# Customize pathfinding connections (optional)
func _pathfinding_does_tile_connect(tile: Vector2i, neighbor: Vector2i) -> bool:
	# Return whether tiles should be connected (default is true)
	return true

	# Enable debug visualization (optional)
	debug_mode = DebugModeFlags.TILES_COORDS | DebugModeFlags.CONNECTIONS

#region:tool工具部分
func _save_config() -> void:
	Log.info("保存配置")
	
	var new_config = GameBoardConfig.new()
	if FileAccess.file_exists(GameBoardConfig.ResourcePath.format([str(config_id)])):
		new_config = ResourceLoader.load(GameBoardConfig.ResourcePath.format([str(config_id)]))
	for cell in get_used_cells_by_id(0,Vector2i(0,0)):
		new_config.grid_sets[cell] = GameBoardConfig.GridType.Empyty
	for cell in get_used_cells_by_id(1,Vector2i(0,0)):
		new_config.grid_sets[cell] = GameBoardConfig.GridType.Block
	new_config.game_board_size = get_used_rect()
	GameBoardConfig.save_config(new_config,config_id)
	_load_config()
	

func _load_config()->void:
	if config_id > -1:
		var config = GameBoardConfig.load_config(config_id)
		if config == null:
			Log.error("加载配置失败")
			return
		game_board_config = config

func _try_load_config(res:GameBoardConfig) -> void:
	clear()
	var grid_sets = res.grid_sets
	print(grid_sets.keys())
	for cell in grid_sets.keys():
		var grid_type = grid_sets[cell]
		if grid_type == GameBoardConfig.GridType.Empyty:
			set_cell(cell, 0,Vector2i(0,0))
			
		elif grid_type == GameBoardConfig.GridType.Block:
			set_cell(cell, 1,Vector2i(0,0))
			Log.info("设置格子类型:{0}".format([grid_type]))
	
	set_debug_viusal()

func set_debug_viusal()->void:
	await ready
	for child in $"../../Logic/Debug".get_children():
		remove_child(child)
		child.queue_free()
	var grid_sets = game_board_config.grid_sets
	for cell in grid_sets.keys():
		create_debug_label(str(cell),map_to_local(cell))

func create_debug_label(content:String, global_pos:Vector2) -> void:
	var prefab := DEBUG_LABEL.instantiate()
	prefab.content = content
	prefab.global_position = global_pos
	$"../../Logic/Debug".add_child(prefab)
#endregion
