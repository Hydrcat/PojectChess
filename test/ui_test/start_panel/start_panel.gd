extends UIPanel
class_name StartPanel

func _on_begin_pressed() -> void:
	switch_to("GamePanel")
	


func _on_settings_pressed() -> void:
	switch_to("SettingPanel")
	
func _on_exit_pressed() -> void:
	GameSignalBus.instance.game_over.emit()
