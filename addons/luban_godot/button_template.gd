@tool
extends HBoxContainer

var text: String = "button_template"

signal open_excel
signal delete_excel

@onready var main_button: Button = $main_button
@onready var delete_button: Button = $delete_button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_button.text = text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_delete_focus_entered() -> void:
	delete_excel.emit()


func _on_main_button_pressed() -> void:
	open_excel.emit()
