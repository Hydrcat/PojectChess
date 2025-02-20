extends UIPanel 
class_name SettingPanel

func _on_show()->void:
	Log.info("setting is show")
	pass
	
func _on_close()->void:
	Log.info("setting is hide")
	pass


func _on_button_pressed() -> void:
	switch_to("StartPanel")
	
