extends KinematicBody2D

const MAXSPEED = 100
const GRAVITY = 20
const MAXFALLSPEED = 200
const UP = Vector2(0,-1)
const ACCEL = 8
const JUMPFORCE = 600

var jump_cooldown = 1
var jump_timer = 4

var motion = Vector2()

var attacking = false

func _ready():
	Global.player_body = self
	Global.current_player_health = Global.MAX_PLAYER_HEALTH
	self.position = Vector2(393, 244)
	
	
func _physics_process(delta):
	if !Global.dialogue_playing:
		if Global.current_player_health <= 0:
			print("died")
		
		motion.y += GRAVITY
		if motion.y > MAXFALLSPEED:
			motion.y = MAXFALLSPEED
		
		motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
		
		if $AnimatedSprite.animation == "attack" and $AnimatedSprite.get_frame() == 3:
			$HitBox/CollisionShape2D.disabled = false
		
		jump_timer += 1*delta
		
		if Input.is_action_pressed("ui_up") and jump_timer >= jump_cooldown:
			if is_on_floor():
				motion.y = -JUMPFORCE
				$AnimatedSprite.play("jump")
				jump_timer = 0
		elif Input.is_action_pressed("ui_left") and !attacking:
			$AnimatedSprite.flip_h = true
			$HitBox/CollisionShape2D.position.x = -25
			$AnimatedSprite.play("walk")
			motion.x -= ACCEL
		elif Input.is_action_pressed("ui_right") and !attacking:
			$AnimatedSprite.flip_h = false
			$HitBox/CollisionShape2D.position.x = 28.75
			$AnimatedSprite.play("walk")
			motion.x += ACCEL
		else:
			motion.x = lerp(motion.x, 0, 0.2)
			if !attacking: $AnimatedSprite.play("idle")
		if Input.is_action_just_pressed("attack"):
			$AnimatedSprite.play("attack")
			attacking = true
		
		motion = move_and_slide(motion, UP)


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "attack":
		$HitBox/CollisionShape2D.disabled = true
		attacking = false


func _on_HitBox_body_entered(body):
	Global.current_boss_health -= 1

