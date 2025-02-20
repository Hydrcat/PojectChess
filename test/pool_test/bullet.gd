extends Node2D

var direction: Vector2 = Vector2(0, 0)
var speed: float = 100

@onready var timer: Timer = get_node("DieTimer")
@onready var pool_componet: PoolNodeComponent = get_node("PoolNodeComponent")

func born() -> void:
	timer.start()
	print("born")
	self.show()
	create_tween().tween_property(
		self,
		"position",
		Vector2(100, 100), 1, ).from(Vector2(0, 0))
	
func die() -> void:
	hide()
	pool_componet.sleep()

func _ready() -> void:
	timer.timeout.connect(func ():
		die()
	)

func on_live(delta: float) -> void:
	position += direction * speed * delta
