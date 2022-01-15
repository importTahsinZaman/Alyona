extends AnimatedSprite

func _ready():
	play("default")

func _on_Game_finished_eyes_animation_finished():
	stop()
	frame = 4
	$CanvasModulate/AnimationPlayer.play("fade_out")
