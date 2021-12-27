extends Control

func _ready():
	if Global.first_dialogue_shown: 
		self.hide()
	else:
		self.show()
		$Text2.hide()
		$Text3.hide()

func _process(delta):
	if self.is_visible():
		Global.dialogue_playing = true
	else:
		Global.dialogue_playing = false
	if self.is_visible() and Input.is_action_just_pressed("interact"):
		if $Text3.visible == true:
			self.hide()
			Global.first_dialogue_shown = true
		else:
			if $Text2.visible == false:
				$Text2.show()
			elif $Text3.visible == false:
				$Text3.show()

