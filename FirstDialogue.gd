extends Control

export (String) var person1
export (String) var person2
export (String) var person1_string_dialogue
export (String) var person2_string_dialogue

var person1_dialogue
var person2_dialogue

var dialogue_index
var max_person1_index
var max_person2_index

func _ready():
	if Global.first_dialogue_shown: self.hide()
	else: self.visible = true
	person1_dialogue = person1_string_dialogue.rsplit("#")
	person2_dialogue = person2_string_dialogue.rsplit("#")
	dialogue_index = 0
	max_person1_index = len(person1_dialogue) - 1
	max_person2_index = len(person2_dialogue) - 1
	person1 = person1 + ": "
	person2 = person2 + ": "
	$Person1Text.text = person1 + person1_dialogue[dialogue_index]



func _process(delta):
	if self.is_visible():
		Global.dialogue_playing = true
	else:
		Global.dialogue_playing = false
	if self.is_visible() and Input.is_action_just_pressed("interact"):
		if $Person2Text.text == "":
			if dialogue_index <= max_person2_index:
				$Person2Text.text = person2 + person2_dialogue[dialogue_index]
			else:
				self.hide()
				Global.first_dialogue_shown = true
		
		else:
			dialogue_index += 1
			if dialogue_index <= max_person1_index:
				$Person2Text.text = ""
				$Person1Text.text = person1 + person1_dialogue[dialogue_index]
			else:
				self.hide()
				Global.first_dialogue_shown = true

