extends UIPanel
class_name UnitPanel



func _on_button_pressed() -> void:
	UISignalBus.instance.add_unit_panel.emit()
