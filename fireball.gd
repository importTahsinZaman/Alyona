extends KinematicBody2D

var velocity = Vector2(1,0)
var speed = 300

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)


func _on_Area2D_body_entered(body):
	queue_free()
	Global.current_player_health -= 1
