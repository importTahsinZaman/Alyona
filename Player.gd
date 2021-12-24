extends KinematicBody2D

enum{
	MOVE,
	IDLE,
	ATTACK
}

var state = IDLE

const MAXSPEED = 60
const GRAVITY = 20
const MAXFALLSPEED = 200
const UP = Vector2(0,-1)
const ACCEL = 8

var motion = Vector2()

var attacking = false
var attack_cooldown = 0

func _ready():
	if Global.return_to_town: self.position = Global.last_player_location
	Global.player_body = self
	
func set_attacking(): attacking = false
	
func _physics_process(delta):
	attack_cooldown += 1 * delta
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if attacking: 
		motion.x = lerp(motion.x, 0, 0.2)
		$AnimationPlayer.play("Attack")
	elif Input.is_action_pressed("interact"):
		motion.x = lerp(motion.x, 0, 0.2)
		attacking = true
	elif Input.is_action_pressed("ui_left") and self.position.x > Global.camera_clamps.x + 15:
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
