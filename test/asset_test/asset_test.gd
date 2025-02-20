extends Node2D


func _ready() -> void:
	var icon :=  HydrcatFramework.asset_manager.load_asset("Image","icon")
	var icon_sprite := Sprite2D.new()
	icon_sprite.texture = icon	
	$Marker2D.add_child(icon_sprite)
