extends AnimatedSprite

func _ready():
	connect("animation_finished", self, "_on_animation_finished")
	play("Animate")

func _physics_process(delta):
	if get_frame() == 3 or get_frame() == 4 or get_frame() == 5:
		$Area2D/CollisionShape2D.disabled = false
	else:
		$Area2D/CollisionShape2D.disabled = true

func _on_animation_finished():
	queue_free()

func _on_Area2D_body_entered(body):
	print(body)
	Global.current_player_health -= 1
	print(Global.current_player_health)
