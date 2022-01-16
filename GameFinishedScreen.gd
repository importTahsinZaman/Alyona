extends Node2D

func _ready():
	$RichTextLabel.hide()
	$CreatedBy.hide()
	$Game_finished_eyes.play("default")

func _on_Game_finished_eyes_animation_finished():
	$Game_finished_eyes.stop()
	$Game_finished_eyes.frame = 4
	$CanvasModulate/AnimationPlayer.play("fade_out")

func show_thanks():
	$Game_finished_eyes.frame = 0
	$RichTextLabel.show()
	$CreatedBy.show()
	
