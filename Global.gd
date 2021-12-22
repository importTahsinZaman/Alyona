extends Node

var camera_clamps = Vector2(0,416)
var last_player_location = Vector2(162,130)
var return_to_town = false
var night_cycle_time = 0

func change_house(building : PackedScene, left_clamp, right_clamp):
	return_to_town = !return_to_town
	if building != null: 
		camera_clamps = Vector2(left_clamp, right_clamp)
		get_tree().change_scene(building.resource_path)
	else:
		camera_clamps = Vector2(-1185, 2255)
		get_tree().change_scene("res://.mono/World.tscn")
