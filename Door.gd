extends Area2D

export var home_of = ""

func _ready():
	$Label.text = "(E) Enter"
	$Label.visible = false


func _on_Area2D_body_entered(body):
	$Label.visible = true


func _on_Area2D_body_exited(body):
	$Label.visible = false
