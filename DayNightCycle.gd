extends CanvasModulate

func _process(delta):
	$AnimationPlayer.play("DayNight")
	$AnimationPlayer.seek(Global.current_frame)

