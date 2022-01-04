extends Node

const MAX_PLAYER_HEALTH = 10
var current_player_health = MAX_PLAYER_HEALTH

const MAX_ALYONA_HEALTH = 1

var camera_clamps = Vector3(0,416, -25)
var camera_zoom_position = [1.3, 1.4, 2, -82]
var last_player_location = Vector2(162,130)
var return_to_town = false
var player_body = null

var seconds_til_night = 180
var current_frame = 0
var time = 1
var is_night = false

var dialogue_playing = false
var first_dialogue_shown = false

var num_alyonas = 0

var kill_counter = 0

var first_kill = false

var player_dialogue_pos
var dialogue_to_play
var return_scene
var return_from_dialogue = false

const MAX_BOSS_HEALTH = 20
var current_boss_health = MAX_BOSS_HEALTH

var spoken_with_rask = false

var return_from_death

signal spawn_alyona

func _process(delta):
	if !is_night:
		time += 1 * delta
		current_frame = range_lerp(time , 0, seconds_til_night, 0, 24)
		if current_frame >= 24:
			is_night = true
			turned_night()
	if num_alyonas < 0:
		num_alyonas = 0

func turned_night():
	pass


func change_house(building : PackedScene, left_clamp, right_clamp, top_clamp, x_zoom, y_zoom, x_pos, y_pos):
	return_to_town = !return_to_town
	if building != null: 
		camera_clamps = Vector3(left_clamp, right_clamp, top_clamp)
		get_tree().change_scene(building.resource_path)
	else:
		camera_clamps = Vector3(-1185, 2255, -75.6)
		camera_zoom_position = [1.3, 1.4, 2, -82]
		get_tree().change_scene("res://World.tscn")
	if x_zoom != 0:
		camera_zoom_position = [x_zoom, y_zoom, x_pos, y_pos]
		
func change_dialogue(dialogue, player_pos, target_return_scene):
	dialogue_to_play = dialogue
	return_scene = target_return_scene
	player_dialogue_pos = player_pos
	get_tree().change_scene("res://Dialogue.tscn")
	camera_clamps = Vector3(0, 320, 0)
	camera_zoom_position = [1, 1, 1, -72]


func _on_Timer_timeout():
	emit_signal("spawn_alyona")
