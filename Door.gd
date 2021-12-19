extends Area2D

onready var body = get_parent().get_node("Player")

export (PackedScene) var building
export (int) var left_clamp
export (int) var right_clamp

func _ready():
	$Label.text = "(E) Enter"
	$Label.visible = false

func _physics_process(delta):
	if overlaps_body(body) and Input.is_action_just_pressed("interact"):
		get_parent().change_house(building, left_clamp, right_clamp)
		if building != null:
			Global.last_player_location = self.position


func _on_Area2D_body_entered(body): $Label.visible = true
func _on_Area2D_body_exited(body): $Label.visible = false
