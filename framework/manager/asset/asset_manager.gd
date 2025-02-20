extends ManagerBase
class_name AssetManager

# 资源管理器
@export var asset_colllector: AssetHelper

## 加载资源，目前只是封装
static func load(path: String) -> Resource:
	return load(path) as Resource

## 按名,获取资源路径
func get_asset_path(asset_type: StringName, asset_name: StringName) -> StringName:
	return asset_colllector.get_asset_path(asset_type, asset_name)

## 按名，加载资源
func load_asset(asset_type: StringName, asset_name: StringName) -> Resource:
	var path: String = get_asset_path(asset_type, asset_name)
	if path.is_empty():
		printerr("资源不存在:", asset_name)
		return null
	return load(path) as Resource

## 按组，加载所有资源
func load_group_asset(asset_type: StringName) -> Array:
	var asset_array: Array[Resource] = []
	for path in asset_colllector.asset_path_dict[asset_type].values():
		var asset = load(path) as Resource
		if asset != null:
			asset_array.append(asset)
	return asset_array

## 按组，获得指定组的字典
func get_asset_group(asset_type: StringName) -> Dictionary:
	return asset_colllector.asset_path_dict[asset_type]

## TODO:异步加载资源
func load_asset_async(asset_type: StringName, asset_name: StringName) -> void:
	pass
