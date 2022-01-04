extends Area2D

onready var body = get_parent().get_node("Player")
signal first_leave

func _ready():
	$Label.text = "(E) Exit"
	$Label.visible = false

func _physics_process(delta):
	if Global.num_alyonas > 0:
		$Label.text = "Alyona is nearby"
	elif Global.first_kill == false:
		$Label.text = "Kill Alyona"
	else:
		$Label.text = "(E) Exit"
	if !Global.spoken_with_rask and Global.first_kill and Global.num_alyonas == 0 and overlaps_body(body) and Input.is_action_just_pressed("interact"):
		get_parent().get_node("Leave Dialogue").show()
	elif Global.first_kill and Global.num_alyonas == 0 and overlaps_body(body) and Input.is_action_just_pressed("interact"):
		Global.change_house(null,null,null, -75.6, 0, 0, 0, 0)
		Global.last_player_location = Vector2(-978, 127) #(-978, 127)

func _on_AlyonaHouseDoor_body_entered(body):
	$Label.visible = true

func _on_AlyonaHouseDoor_body_exited(body):
	$Label.visible = false
