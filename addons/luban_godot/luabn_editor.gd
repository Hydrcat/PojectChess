@tool
extends Control

@onready var open_path_button: Button = $VBoxContainer/open_path_button
@onready var export_button: Button = $VBoxContainer/export_button
@onready var refresh_button: Button = $VBoxContainer/refresh_button
@onready var create_button: Button = $VBoxContainer/create_button
@onready var error_label: Label = $VBoxContainer/error_label

@onready var excel_list: VBoxContainer = $VBoxContainer/ScrollContainer/ExcelList
@onready var button_template := preload("res://addons/luban_godot/button_template.tscn")
@onready var add_new_button: Button = $VBoxContainer/ScrollContainer/ExcelList/AddNew/add_new_button
@onready var add_new_edit: LineEdit = $VBoxContainer/ScrollContainer/ExcelList/AddNew/new_edit


var _path: String
var _pids: Array[int]
var _bat_name: String
var _post_process_name: String
var _is_initialized: bool = false:
	set(v):
		if v:
			refresh_button.show()
			create_button.hide()
			error_label.hide()
			export_button.show()
			open_path_button.show()
			excel_list.show()
		else:
			refresh_button.hide()
			create_button.show()
			error_label.show()
			export_button.hide()
			open_path_button.hide()
			excel_list.hide()
	

var luban_tools_path := "res://addons/luban_godot/LubanTool"
var gen_path := "res://data"
var template_folder := "res://addons/luban_godot/template_folder"
var excel_folder := "res://_excel"
var template_excel := "res://addons/luban_godot/template.xlsx"


var export_command: PackedStringArray = []

func _ready() -> void:

	open_path_button.pressed.connect(open_path)
	export_button.pressed.connect(export )
	refresh_button.pressed.connect(refresh)
	create_button.pressed.connect(move_config_folder)
	export_button.disabled = true

	# 检查是否已经存在配置文件夹。
	refresh()

## 检查是否存在配置文件夹
func check_config_folder() -> bool:
	var dir := DirAccess.open("res://")
	if not dir.dir_exists(excel_folder):
		return false
		printerr("Excel文件夹不存在")
	if not dir.file_exists(excel_folder + "/gen.bat"):
		return false
		printerr("gen.bat不存在")
	return true

## 配置路径	
func move_config_folder() -> void:
	var dir := DirAccess.open("res://")
	if copy_dir(template_folder, excel_folder):
		print("模板文件夹复制成功")
	else:
		printerr("模板文件夹复制失败")
	refresh()

## 复制文件夹
func copy_dir(from: String, to: String) -> bool:
	var dir := DirAccess.open(from)
	if not dir.dir_exists(to):
		dir.make_dir(to)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("发现目录：" + file_name)
				dir.make_dir(to + "/" + file_name)
			else:
				dir.copy(from + "/" + file_name, to + "/" + file_name)
			file_name = dir.get_next()
	else:
		return false
	dir.list_dir_end()
	return true

func open_path() -> void:
	var path := excel_folder
	var dir := DirAccess.open(path)
	if not dir:
		new_dir(path)
		dir = DirAccess.open(path)
	open_folder(path)

func refresh() -> void:
	_is_initialized = check_config_folder()
	for pid in _pids:
		OS.kill(pid)
	for child in excel_list.get_children():
		if child.name != "AddNew":
			child.queue_free()
		
	var path := excel_folder
	var dir := DirAccess.open(path)
		
	_path = path
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if dir.current_is_dir():
			pass
		else:
			if file_name.match("*.xlsx"):
				# var button := Button.new()
				# button.pressed.connect(open_excel.bind(file_name))
				# button.name = file_name
				# button.text = file_name
				# excel_list.add_child(button)

				var button_instance = button_template.instantiate()
				button_instance.text = file_name
				button_instance.name = file_name
				button_instance.open_excel.connect(open_excel.bind(file_name))
				button_instance.delete_excel.connect(delete_excel.bind(file_name))
				excel_list.add_child(button_instance)

			elif file_name.match("gen.bat"):
				_bat_name = file_name
			elif file_name.match("post_process.bat"):
				_post_process_name = file_name
				
		file_name = dir.get_next()
	export_button.disabled = false

func new_dir(dir_path) -> void:
	DirAccess.make_dir_absolute(dir_path)
	

func open_excel(excel_name: String) -> void:
	var output = []
	var abs_path = translate_path(_path + "/" + excel_name)
	#OS.execute("CMD.exe", ["/C", abs_path], output)
	var pid = OS.create_process("CMD.exe", ["/C", abs_path])
	_pids.append(pid)
	#OS.shell_show_in_file_manager(abs_path, true)
	print(output)

func delete_excel(excel_name: String) -> void:
	var dir := DirAccess.open(excel_folder)
	if dir:
		var OK := dir.remove(excel_name)
		if OK == OK:
			print("删除成功")
		else:
			printerr("删除失败")
		refresh()
	
func open_folder(path) -> void:
	var output = []
	OS.shell_show_in_file_manager(translate_path(path), true)
	#OS.execute("start",[translate_path(path)],output,true,true)
	print(output)

func translate_path(path: String) -> String:
	return ProjectSettings.globalize_path(path)

func export() -> void:
	var bat_path = translate_path(_path + "/" + _bat_name)
	var excel_path = translate_path(_path)
	var output = []
	
	OS.create_process("powershell.exe", [bat_path], true)
	# better_print_debug(output)
	save_log(output)

func better_print_debug(words: PackedStringArray) -> void:
	var sort_words: PackedStringArray = []
	for word in words:
		var temps := word.split("\n")
		sort_words.append_array(temps)
	
	for word in sort_words:
		print_debug(word)

func save_log(log: String) -> void:
	var file := FileAccess.open(excel_folder + "/log.txt", FileAccess.WRITE)
	if file == null:
		printerr("文件打开失败")
		return
	file.store_string(log)
	file.close()
	print("日志已保存")

func add_new_excel(excel_name: String) -> void:
	var dir := DirAccess.open(excel_folder)
	if not dir:
		new_dir(excel_folder)
		dir = DirAccess.open(excel_folder)
	if dir.file_exists(excel_folder + "/" + excel_name + ".xlsx"):
		printerr("文件已存在")
		return
	
	dir.copy(template_excel, excel_folder + "/" + excel_name + ".xlsx")
	refresh()


func _on_add_new_button_pressed() -> void:
	add_new_button.hide()
	add_new_edit.show()



func _on_new_edit_text_submitted(new_text: String) -> void:
	if new_text.match("#*"):
		new_text = new_text.replace("#", "")
		new_text = new_text.to_pascal_case()
		new_text = "#" + new_text
	else :
		new_text = new_text.to_pascal_case()
	if new_text == "":
		return
	if new_text.match("*.xlsx"):
		new_text = new_text.replace(".xlsx", "")

	add_new_edit.clear()
	add_new_edit.hide()
	add_new_button.show()
	add_new_excel(new_text)
