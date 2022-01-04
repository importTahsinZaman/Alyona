extends Control

const CHECKPOINT = preload("res://Checkpoint.tscn")

func _process(delta):
	if self.is_visible():
		Global.dialogue_playing = true
	else:
		Global.dialogue_playing = false
	if self.is_visible() and Input.is_action_just_pressed("interact"):
		var checkpoint = CHECKPOINT.instance()
		get_parent().add_child(checkpoint)
		checkpoint.position = get_parent().get_node("Door").position + Vector2(-10, -22)
		queue_free()
		Global.dialogue_playing = false
