extends Node2D

@export var move_speed: float = 10

@onready var game_board: GameBoard = $GameBoard
@onready var camera: Camera2D = $Camera2D
@onready var level_interact: LevelInteract = $LevelInteract

@onready var role_controller: RoleController = $RoleController
@onready var level_controller: LevelController = $LevelController

func _ready() -> void:
	init_level()
	GameSignalBus.instance.camera_move_to.connect(_on_camera_move_to)
	level_interact.map_dragging.connect(_on_camera_move_to)
	level_interact.map_clicked.connect(_on_map_clicked)
	

func _on_camera_move_to(_position: Vector2, direction: Vector2) -> void:
	camera.position -= direction * move_speed * get_process_delta_time()

func _on_map_clicked(pos: Vector2) -> void:
	# 将视窗中的位置转化为世界坐标

	var now_pos := pos + camera.position
	Log.info("camera:"+str(now_pos))
	game_board._on_map_clicked(now_pos)

func init_level() -> void:
	camera.position = game_board.get_center_pos() - camera.get_viewport_rect().size / 2
	Log.info(str(game_board.get_center_pos()))