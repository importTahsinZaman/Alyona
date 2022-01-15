extends CanvasModulate

func fade_in():
	self.show()
	$AnimationPlayer.play("transition")

func del_eyes():
	get_parent().get_node("eyes").hide()
	get_parent().get_node("eyes").queue_free()

func animation_finished():
	queue_free()
	Global.dialogue_playing = false;


