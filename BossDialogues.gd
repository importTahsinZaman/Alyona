extends Control

const ALYONA = preload("res://Alyona.tscn")
var rng = RandomNumberGenerator.new()

func _ready():
	self.hide()
	

func _process(delta):
	if self.is_visible():
		Global.dialogue_playing = true
	if self.is_visible() and Input.is_action_just_pressed("interact"):
		self.queue_free()
		Global.dialogue_playing = false
		get_parent().get_node("FinalPlayer").get_node("Camera2D").zoom = Vector2(2.1, 1.6)

		for i in range(3):
			var alyona = ALYONA.instance()
			get_parent().add_child(alyona)
			alyona.position = Vector2(rng.randf_range(15, 657), 180)
