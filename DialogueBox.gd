extends Area2D

onready var body = get_parent().get_node("Player")

export (String) var self_name
export (String) var self_location

func _ready():
	$Label.visible = false
	$Label.text = "(E) Speak"
	

func _physics_process(delta):
	if overlaps_body(body) and Input.is_action_just_pressed("interact"):
		Global.change_dialogue(self_name, self.position, self_location)
	
func _on_DialogueBox_body_entered(body):
	$Label.visible = true


func _on_DialogueBox_body_exited(body):
	$Label.visible = false
