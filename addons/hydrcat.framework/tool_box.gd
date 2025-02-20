@tool
extends Node

const framework_files := "res://framework/"
const GEN_HELPER_PATH := "res://framework/_settings/need_gen_helper.tres"
var helper_res : NeedGenHelper

func _enter_tree() -> void:
	$Button.pressed.connect(regen_all)

func regen_all() -> void:
	if not helper_res:
		helper_res = load(GEN_HELPER_PATH)
	helper_res.gen()
	
	for need_gen in helper_res.need_gens:
		need_gen.gen()
