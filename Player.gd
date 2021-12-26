extends KinematicBody2D

const MAXSPEED = 80
const GRAVITY = 20
const MAXFALLSPEED = 200
const UP = Vector2(0,-1)
const ACCEL = 8
const JUMPFORCE = 500

var motion = Vector2()

var attacking = false

func _ready():
	$HitBox/CollisionShape2D.disabled = true
	if Global.return_to_town: self.position = Global.last_player_location
	Global.player_body = self
	
	
func _physics_process(delta):
	if Global.current_player_health <= 0:
		print("died")
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if $AnimatedSprite.animation == "attack" and $AnimatedSprite.get_frame() == 3:
		$HitBox/CollisionShape2D.disabled = false
	
	
	if Input.is_action_pressed("ui_up"):
		if is_on_floor():
			motion.y = -JUMPFORCE
			$AnimatedSprite.play("jump")
	elif Input.is_action_pressed("ui_left") and self.position.x > Global.camera_clamps.x + 15 and !attacking:
		$AnimatedSprite.flip_h = true
		$HitBox/CollisionShape2D.position.x = -25
		$AnimatedSprite.play("walk")
		motion.x -= ACCEL
	elif Input.is_action_pressed("ui_right") and self.position.x < Global.camera_clamps.y - 15 and !attacking:
		$AnimatedSprite.flip_h = false
		$HitBox/CollisionShape2D.position.x = 28.75
		$AnimatedSprite.play("walk")
		motion.x += ACCEL
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		if !attacking: $AnimatedSprite.play("idle")
	if Input.is_action_just_pressed("interact"):
		$AnimatedSprite.play("attack")
		attacking = true
	
	motion = move_and_slide(motion, UP)


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "attack":
		$HitBox/CollisionShape2D.disabled = true
		attacking = false


func _on_HitBox_body_entered(body):
	body.health -= 1
