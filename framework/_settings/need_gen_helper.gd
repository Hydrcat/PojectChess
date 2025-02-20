@tool
class_name NeedGenHelper extends NeedGen
## 收集所有的NeedGen资源

const PATH := &"res://"

@export var need_gens: Array[NeedGen]
@export var gen_button: bool:
	set(v):
		if v != gen_button:
			gen()

func gen() -> void:
	collect_all_need_gen(PATH)

## 收集所有的needGen
func collect_all_need_gen(path: StringName) -> void:
	if not Engine.is_editor_hint():
		return
	Log.split_line("收集NeedGen")
	need_gens = []
	find_file(PATH)
	Log.split_line("NeedGen结束")

func find_file(path: StringName) -> void:
	var dir := DirAccess.open(path)
	if not dir:
		printerr("文件夹不存在:", path)
		return
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	var dir_name = dir.get_current_dir(false)

	while file_name != "":
		if dir.current_is_dir():
			find_file(dir_name + "/" + file_name)
			
		else:
			if file_name.match("*.tres"):
				if file_name != "need_gen_helper.tres":
					check_res(dir_name + "/" + file_name)
		file_name = dir.get_next()
		
func check_res(file_name: String) -> void:
	var res := load(file_name)
	if res is NeedGen:
		need_gens.append(res)
		Log.info("尝试添加needgen:{file_name}".format({"file_name": file_name}))
