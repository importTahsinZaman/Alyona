extends Control

func _ready():
	pass 
	
func _on_StartButton_pressed():
	get_tree().change_scene("res://AlyonaHouse.tscn")


func _on_AboutButton_pressed():
	pass # Replace with function body.


func _on_QuitButton_pressed():
	get_tree().quit()
