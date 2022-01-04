extends CanvasModulate

func play():
	Global.dialogue_playing = true
	get_parent().get_node("eyes").show()
	$AnimationPlayer.play("transition")
	
func del_key():
	get_parent().get_node("eyes").queue_free()
	
func del_self():
	queue_free()
	Global.dialogue_playing = false


