extends CanvasModulate

signal night_time

onready var time = Global.night_cycle_time

var seconds_til_night = 20
var current_frame = 0

func _process(delta):
	if current_frame < 24:
		time += 1 * delta
		Global.night_cycle_time = time
		current_frame = range_lerp(time , 0, seconds_til_night, 0, 24)
		$AnimationPlayer.play("DayNight")
		$AnimationPlayer.seek(current_frame)
		if current_frame >= 24:
			set_process(false)
			emit_signal("night_time")
