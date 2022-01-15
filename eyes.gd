extends AnimatedSprite

func close():
	self.show()
	play("eyes_closing")


func _on_eyes_animation_finished():
	get_parent().get_node("eyes_modulate").fade_in()
