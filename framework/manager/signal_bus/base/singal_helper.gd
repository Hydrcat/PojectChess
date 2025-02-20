@tool
extends NeedGen
class_name SignalHelper

## 文件位置
const SIGNAL_BUS_FLODER := "res://signal/gen/"
const CUSTOM_SIGNAL_BUS_FLODER := "res://signal/"

## 文件模板
const SIGNAL_BUS_TEMPLATE := "res://framework/manager/signal_bus/template/singal_bus_template.txt"
const CUSTOM_SIGNAL_BUS_TEMPLATE := "res://framework/manager/signal_bus/template/custom_signal_bus_template.txt"

## 生成代码
@export var generate_button: bool:
	set(v):
		if v != generate_button:
			collect_signal()

## 代码生成
@export var signal_bus_name: StringName
@export var signal_configs: Array[SignalConfig]
@export var is_enable_custom_signal: bool

var signal_bus_file_name: StringName:
	get:
		return signal_bus_name.to_snake_case() + ".gd"

func gen() -> void:
	collect_signal()

## 收集信号
func collect_signal() -> void:
	if not Engine.is_editor_hint():
		return
	Log.split_line("检查是否存在文件夹")
	if not FileAccess.file_exists(SIGNAL_BUS_FLODER):
		Log.info("指定文件夹不存在")
		var dir := DirAccess.open("res://")
		dir.make_dir(CUSTOM_SIGNAL_BUS_FLODER)
		dir.make_dir(SIGNAL_BUS_FLODER)
	
	Log.split_line("收集Signal")
	clear_folder(SIGNAL_BUS_FLODER)
	var codes := generate_signal_code()
	generate_code_file(codes, SIGNAL_BUS_FLODER + signal_bus_file_name)
	# 生成完毕
	EditorInterface.get_resource_filesystem().scan()
	Log.split_line("Signal收集结束")
	

## 清理同名文件
func clear_folder(folder_path: String) -> void:
	var dir = DirAccess.open(folder_path)
	if dir.file_exists(signal_bus_file_name):
		dir.remove(signal_bus_file_name)

## 生成代码信号
func generate_signal_code() -> String:
	var singals_code: String
	# 加载模板
	singals_code = load_text_file(SIGNAL_BUS_TEMPLATE)
	singals_code = singals_code.replace("{class_name}", signal_bus_name)
	if is_enable_custom_signal:
		var custom_signal_name := signal_bus_name + "Custom"
		var l_custom_signal_name := custom_signal_name.to_snake_case()
		singals_code = singals_code.replace("{father_class_name}", custom_signal_name)
		generate_custom_code_file(CUSTOM_SIGNAL_BUS_FLODER + l_custom_signal_name + ".gd")
		
	else:
		singals_code = singals_code.replace("{father_class_name}", "Node")
	for config in signal_configs:
		var signal_name = config.singal_name
		var signal_code = "signal " + signal_name + "("
		if config.params.size() > 0:
			for i in range(config.params.size()):
				var param = config.params[i]
				signal_code += param.name + ": " + param.type
				if i < config.params.size() - 1:
					signal_code += ", "
		signal_code += ")\n"
		singals_code += signal_code
	return singals_code

## 生成自定义信号代码
func generate_custom_code_file(file_path: String) -> void:
	if FileAccess.file_exists(file_path):
		Log.info("custom_signal已存在:{name}", {"name": file_path})
		return
	Log.info("custom_signal文件不存在,生成文件:{name}", {"name": file_path})

	var file = FileAccess.open(file_path, FileAccess.WRITE)
	var signals_code = load_text_file(CUSTOM_SIGNAL_BUS_TEMPLATE)
	signals_code = signals_code.replace("{class_name}", signal_bus_name)
	signals_code = signals_code.replace("{father_class_name}", signal_bus_name + "Custom")
	file.store_string(signals_code)
	file.close()


## 生成代码文件
func generate_code_file(code: String, file_path: String) -> void:
	Log.info("生成SignalBus:{name}", {name = file_path})
	var reigion_end := "#endregion"
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(code + reigion_end)
	file.close()


## 加载文本文件
func load_text_file(file_path: String) -> String:
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	return content
