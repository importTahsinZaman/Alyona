extends KinematicBody2D

var velocity = Vector2(1,0)
var speed = 500

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
	if self.position.x >= 675: 
		queue_free()


func _on_Area2D_body_entered(body):
	queue_free()
	Global.current_player_health -= 1
