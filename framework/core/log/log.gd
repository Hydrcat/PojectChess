extends Node
class_name Log
## 日志


## 提示
static func info(msg: String,args:Dictionary = {}) -> void:
	msg = msg.format(args)
	print_debug(msg)

## 警告
static func warn(msg: String,args:Dictionary = {}) -> void:
	msg = msg.format(args)
	print_debug(msg)

## 错误
static func error(msg: String,args:Dictionary = {}) -> void:
	msg = msg.format(args)
	print_debug(msg)

## 打印分割线
static func split_line(content:String) -> void:
	var line := "=================="
	print(line + content + line)
