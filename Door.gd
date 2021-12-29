extends Area2D

onready var body = get_parent().get_node("Player")

export (PackedScene) var building
export (int) var left_clamp
export (int) var right_clamp
export (int) var top_clamp
export (float) var x_zoom
export (float) var y_zoom
export (float) var x_pos
export (float) var y_pos

func _ready():
	if building != null: $Label.text = "(E) Enter"
	elif building == null: $Label.text = "(E) Exit"
	$Label.visible = false

func _physics_process(delta):
	if Global.num_alyonas > 0:
		$Label.text = "Alyona is nearby"
	else:
		if building != null: $Label.text = "(E) Enter"
		elif building == null: $Label.text = "(E) Exit"
	if Global.num_alyonas == 0 and overlaps_body(body) and Input.is_action_just_pressed("interact"):
		Global.change_house(building, left_clamp, right_clamp, top_clamp, x_zoom, y_zoom, x_pos, y_pos)
		if building != null:
			Global.last_player_location = self.position
	elif Input.is_action_just_pressed("interact"):
		print("Num Alyonas: " + str(Global.num_alyonas))
		print("Overlapping: " + str(overlaps_body(body)))

func _on_Area2D_body_entered(body): $Label.visible = true
func _on_Area2D_body_exited(body): $Label.visible = false
