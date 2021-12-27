extends Control

func _process(delta):
	if self.is_visible():
		Global.dialogue_playing = true
	else:
		Global.dialogue_playing = false
	if self.is_visible() and Input.is_action_just_pressed("interact"):
			queue_free()
