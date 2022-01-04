extends Control

func _ready():
	self.show()
	

func _process(delta):
	if self.is_visible():
		Global.dialogue_playing = true
	if self.is_visible() and Input.is_action_just_pressed("interact"):
		self.queue_free()
		Global.dialogue_playing = false
		get_parent().get_node("FinalPlayer").get_node("Camera2D").zoom = Vector2(2.1, 1.6)

		get_parent().get_node("Transition").show()
		get_parent().get_node("Transition").get_node("AnimationPlayer").play("Transition")
