extends Control


func _on_Button_pressed():
	Global.set_script(null)
	Global.set_script(preload("res://Global.gd"))
	get_tree().change_scene("res://Menu.tscn")
