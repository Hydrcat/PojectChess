extends Node


func _ready() -> void:
	GameSignalBus.instance.game_over.connect(func():
		get_tree().quit()
		)
