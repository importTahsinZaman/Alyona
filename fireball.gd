extends KinematicBody2D

var velocity = Vector2(1,0)
var speed = 300

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
	if !Global.spoken_with_rask and (!(self.position.x > Global.camera_clamps.x) or !(self.position.x < Global.camera_clamps.y)):
		queue_free()
	elif Global.spoken_with_rask and ((self.global_position.x < 0) or (self.global_position.x > 672)):
		queue_free()

func _on_Area2D_body_entered(body):
	queue_free()
	Global.current_player_health -= 1
