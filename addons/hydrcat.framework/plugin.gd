@tool
extends EditorPlugin

const TOOL_BUTTON = preload("res://addons/hydrcat.framework/tool_button.tscn")
var tool_button:Control

func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	add_autoload_singleton("HydrcatFramework","res://framework/hydrcat_framework.tscn")
	tool_button = TOOL_BUTTON.instantiate()
	add_control_to_container(CONTAINER_TOOLBAR, tool_button)


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_autoload_singleton("HydrcatFramework")
	remove_control_from_container(CONTAINER_TOOLBAR,tool_button)
