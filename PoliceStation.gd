extends Node2D


func change_house(building : PackedScene, left_clamp, right_clamp):
	Global.camera_clamps = Vector2(left_clamp, right_clamp)
	get_tree().change_scene(building.resource_path)
