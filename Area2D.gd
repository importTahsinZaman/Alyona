extends Area2D

onready var body = get_parent().get_node("Player")

func _ready():
	$Label.text = "(E) Exit"
	$Label.visible = false

func _physics_process(delta):
	if overlaps_body(body) and Input.is_action_just_pressed("interact"):
		Global.change_house(null,null,null, -75.6)
		Global.last_player_location = Vector2(1523, 132)

func _on_AlyonaHouseDoor_body_entered(body):
	$Label.visible = true

func _on_AlyonaHouseDoor_body_exited(body):
	$Label.visible = false
