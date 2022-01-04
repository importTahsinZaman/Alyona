extends Control

func _ready():
	pass # Replace with function body.

func _on_Button_pressed():
	if Global.spoken_with_rask:
		Global.set_script(null)
		Global.set_script(preload("res://Global.gd"))
		get_tree().change_scene("res://FinalArena.tscn")
		Global.spoken_with_rask = true
	else:
		Global.current_player_health = Global.MAX_PLAYER_HEALTH
		Global.num_alyonas = 0
		Global.return_from_death = true
		get_tree().change_scene("res://World.tscn")
