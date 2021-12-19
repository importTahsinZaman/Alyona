extends Node2D


func change_house(building : PackedScene, left_clamp, right_clamp):
	Global.return_to_town = !Global.return_to_town
	if building != null: 
		Global.camera_clamps = Vector2(left_clamp, right_clamp)
		get_tree().change_scene(building.resource_path)
	else:
		Global.camera_clamps = Vector2(-1185, 2255)
		get_tree().change_scene("res://.mono/World.tscn")
