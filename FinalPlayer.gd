extends KinematicBody2D

var MAXSPEED = 100
const GRAVITY = 20
const MAXFALLSPEED = 200
const UP = Vector2(0,-1)
var ACCEL = 14
const JUMPFORCE = 600

var jump_cooldown = 1
var jump_timer = 4

var motion = Vector2()

var attacking = false

func _ready():
	Global.player_body = self
	Global.current_player_health = Global.MAX_PLAYER_HEALTH
	self.position = Vector2(393, 244)
	$Camera2D.zoom = Vector2(1.3, 1.4)
	
	
func _physics_process(delta):
	if !is_on_floor():
		ACCEL = 18
		MAXSPEED = 120
	else:
		ACCEL = 14
		MAXSPEED = 100
	if !Global.dialogue_playing:
		if Global.current_player_health <= 0:
			get_tree().change_scene("res://DeathScreen.tscn")
		
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
	if Global.num_alyonas == 0 and !(body.is_in_group("Alyona")):
		Global.current_boss_health -= 1
		if Global.current_boss_health == int(0.75 * Global.MAX_BOSS_HEALTH):
			$Camera2D.zoom = Vector2(1.3, 1.4)
			get_parent().get_node("75%Dialogue").show()
		elif Global.current_boss_health == int(0.50 * Global.MAX_BOSS_HEALTH):
			get_parent().get_node("50%Dialogue").show()
			$Camera2D.zoom = Vector2(1.3, 1.4)
		elif Global.current_boss_health == int(0.25 * Global.MAX_BOSS_HEALTH):
			get_parent().get_node("25%Dialogue").show()
			$Camera2D.zoom = Vector2(1.3, 1.4)
		elif Global.current_boss_health == 0:
			$Camera2D.zoom = Vector2(1,1)
			get_tree().change_scene("res://GameFinishedScreen.tscn")
	elif body.is_in_group("Alyona"):
		body.health -= 1
	
