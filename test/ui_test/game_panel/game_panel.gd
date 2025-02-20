extends UIPanel
class_name GamePanel

@onready var h_box_container: HBoxContainer = $HBoxContainer

func _ready() -> void:
	UISignalBus.instance.add_unit_panel.connect(on_add_unit_panel)

func on_add_unit_panel()->void:
	# var ps:=HydrcatFramework.asset_manager.load_asset("ui","unit_panel") as PackedScene
	# var node := ps.instantiate()
	# h_box_container.add_child(node)
	open_panel(UI.UNIT_PANEL)

func _on_back_pressed() -> void:
	switch_to("StartPanel")
	
