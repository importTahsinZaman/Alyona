extends KinematicBody2D

const MAXSPEED = 80
const GRAVITY = 20
const MAXFALLSPEED = 200
const UP = Vector2(0,-1)
const ACCEL = 10

var motion = Vector2()

func _ready():
	if Global.return_to_town: self.position = Global.last_player_location
	
func _physics_process(delta):
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if Input.is_action_pressed("ui_left") and self.position.x > Global.camera_clamps.x + 15:
		$Sprite.flip_h = true
		$AnimationPlayer.play("Walk")
		motion.x -= ACCEL
	elif Input.is_action_pressed("ui_right") and self.position.x < Global.camera_clamps.y - 15:
		$AnimationPlayer.play("Walk")
		$Sprite.flip_h = false
		motion.x += ACCEL
	else:
		$AnimationPlayer.play("Idle")
		motion.x = lerp(motion.x, 0, 0.2)
	
	motion = move_and_slide(motion, UP)
