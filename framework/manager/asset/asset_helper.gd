@tool
class_name AssetHelper extends NeedGen

# 资源助手
# 收集指定资源的位置，方便管理

@export var collect_button: bool:
	set(v):
		if v!= collect_button:
			collect_asset()

@export_category("资源路径")
@export var asset_configs: Array[AssetConfig]
@export var asset_path_dict: Dictionary

func gen() -> void:
	collect_asset()

## 收集资源
func collect_asset() -> void:
	Log.split_line("收集Asset")
	asset_path_dict = {}
	for asset_type in asset_configs:
		var t: Dictionary = {}
		asset_path_dict[asset_type.name] = t
		find_resources_in_folder(asset_type)
	Log.split_line("Asset收集结束")
		
## 收集指定地址的资源
func find_resources_in_folder(asset_type: AssetConfig) -> void:
	var asset_name = asset_type.name
	
	var store_dict := asset_path_dict[asset_name] as Dictionary
	store_dict.clear()

	find_file_in_folader(asset_type.path, asset_type, store_dict)

## 遍历寻找文件夹中的资源
func find_file_in_folader(path: StringName, asset_config: AssetConfig, store_dict: Dictionary) -> void:
	var dir := DirAccess.open(path)
	if not dir:
		printerr("文件夹不存在:", path)
		return

	dir.list_dir_begin()
	var file_name = dir.get_next()

	while file_name != "":
		if dir.current_is_dir():
			find_file_in_folader(dir.get_current_dir(false) + "/" + file_name, asset_config, store_dict)
			
		else:
			if file_name.match(asset_config.collect_match):
				Log.info("找到资源:{file_name}".format({"file_name":file_name}))
				var base_file_name: StringName = file_name.get_basename().to_snake_case()
				store_dict[base_file_name] = dir.get_current_dir(false) + "/" + file_name
		file_name = dir.get_next()


## 通过资源名来获取资源路径
func get_asset_path(asset_type: StringName, asset_name: StringName) -> StringName:
	if not asset_path_dict.has(asset_type):
		printerr("资源类型不存在:", asset_type)
		return ""
	
	var store_dict := asset_path_dict[asset_type] as Dictionary
	if not store_dict.has(asset_name):
		printerr("资源不存在:", asset_name)
		return ""
	return store_dict[asset_name]

## 获得指定组的所有资源
func get_group_asset_path(asset_type: StringName) -> Array[StringName]:
	if not asset_path_dict.has(asset_type):
		printerr("资源类型不存在:", asset_type)
		return []
	
	var store_dict := asset_path_dict[asset_type] as Dictionary
	var paths: Array = []
	for k in store_dict.keys():
		paths.append(store_dict[k])
	return paths

## 获得指定组的字典
func get_group_dict(asset_type: StringName) -> Dictionary:
	if not asset_path_dict.has(asset_type):
		printerr("资源类型不存在:", asset_type)
		return {}
	
	return asset_path_dict[asset_type]