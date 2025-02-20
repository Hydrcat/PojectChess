extends Node

@export var bullet_prefab: PackedScene = null

var bullet_pool: NodePool


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			spawn_bullet(event.position)

func spawn_bullet(position: Vector2) -> void:
	var temp := bullet_pool.awake_object()
	temp.position = position
	temp.direction = Vector2.RIGHT
	temp.born()

func _ready() -> void:
	bullet_pool = HydrcatFramework \
		.pool_manager \
		.register_pool("bullet_pool", bullet_prefab, 10)
