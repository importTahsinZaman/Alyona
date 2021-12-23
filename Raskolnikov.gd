extends KinematicBody2D

const MAXSPEED = 80
const GRAVITY = 20
const MAXFALLSPEED = 200
const UP = Vector2(0,-1)
const ACCEL = 10

var motion = Vector2()

func _ready():
	pass 

func _physics_process(delta):
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if self.position.x > Global.player_body.position.x:
		$Sprite.flip_h = true
		$AnimationPlayer.play("Walk")
		motion.x -= ACCEL
	elif self.position.x < Global.player_body.position.x:
		$AnimationPlayer.play("Walk")
		$Sprite.flip_h = false
		motion.x += ACCEL
	else:
		$AnimationPlayer.play("Idle")
		motion.x = lerp(motion.x, 0, 0.2)
	
	motion = move_and_slide(motion, UP)
	
func _on_Area2D_body_entered(body):
	set_process(false)
	print("attack")
