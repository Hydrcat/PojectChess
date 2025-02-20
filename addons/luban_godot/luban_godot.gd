@tool
extends EditorPlugin

var interface


func _enter_tree() -> void:
	interface = preload("res://addons/luban_godot/luabn_editor.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_LEFT_UL,interface)



func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_control_from_docks(interface)
