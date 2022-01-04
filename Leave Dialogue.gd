extends Control

func _ready():
	self.hide()

func _process(delta):
	if self.is_visible():
		Global.dialogue_playing = true
	if self.is_visible() and Input.is_action_just_pressed("interact"):
		Global.change_house(null,null,null, -75.6, 0, 0, 0, 0)
		Global.last_player_location = Vector2(-978, 127) #(-978, 127)
		Global.dialogue_playing = false
