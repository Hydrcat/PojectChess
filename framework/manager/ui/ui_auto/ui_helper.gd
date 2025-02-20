@tool
extends NeedGen
class_name UIHelper

const template_path := "res://framework/manager/ui/ui_auto/ui_static.txt"
const target_path := "res://framework/manager/ui/ui_auto/ui_static.gd"

# 获得各个UI节点的路径
@export var gen_button: bool:
	set(v):
		if v != gen_button:
			gen()

@export var asset_helper: AssetHelper

func gen() -> void:
	## 获得各个UI节点的路径和名称
	if asset_helper == null:
		Log.error("请先设置asset_helper")
		return
	Log.info("生成UIStatic")
	var group := asset_helper.get_group_dict("ui")
	gen_code(group)


func gen_code(group: Dictionary) -> void:
	var template_code := load_text_file(template_path)
	var const_code := gen_const_code(group)
	var final_code := template_code + const_code

	generate_code_file(final_code, target_path)


func load_text_file(file_path: String) -> String:
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	return content

func generate_code_file(code: String, file_path: String) -> void:
	Log.info("生成UIStatic:{name}", {name = file_path})
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(code)
	file.close()

func gen_const_code(group: Dictionary) -> String:
	var template := "const {name} := \"{value}\"\n"
	var code: String = ""
	for key in group.keys():
		code += template.replace("{name}", key.to_upper()).replace("{value}", key)
	return code
