extends Node

const MAX_PLAYER_HEALTH = 10
var current_player_health = MAX_PLAYER_HEALTH

const MAX_ALYONA_HEALTH = 1

var camera_clamps = Vector3(0,416, -25)
var last_player_location = Vector2(162,130)
var return_to_town = false
var player_body = null

var seconds_til_night = 120
var current_frame = 0
var time = 0
var is_night = false

var dialogue_playing
var first_dialogue_shown = false

func _process(delta):
	if !is_night:
		time += 1 * delta
		current_frame = range_lerp(time , 0, seconds_til_night, 0, 24)
		if current_frame >= 24:
			is_night = true
			turned_night()

func turned_night():
	pass


func change_house(building : PackedScene, left_clamp, right_clamp, top_clamp):
	return_to_town = !return_to_town
	if building != null: 
		camera_clamps = Vector3(left_clamp, right_clamp, top_clamp)
		get_tree().change_scene(building.resource_path)
	else:
		camera_clamps = Vector3(-1185, 2255, -75.6)
		get_tree().change_scene("res://World.tscn")
