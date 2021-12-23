extends Node

var camera_clamps = Vector2(0,416)
var last_player_location = Vector2(162,130)
var return_to_town = false
var player_body = null

var seconds_til_night = 20
var current_frame = 0
var time = 0
var is_night = false

func _process(delta):
	if !is_night:
		time += 1 * delta
		current_frame = range_lerp(time , 0, seconds_til_night, 0, 24)
		if current_frame >= 24:
			is_night = true
			turned_night()

func turned_night():
	pass


func change_house(building : PackedScene, left_clamp, right_clamp):
	return_to_town = !return_to_town
	if building != null: 
		camera_clamps = Vector2(left_clamp, right_clamp)
		get_tree().change_scene(building.resource_path)
	else:
		camera_clamps = Vector2(-1185, 2255)
		get_tree().change_scene("res://.mono/World.tscn")
