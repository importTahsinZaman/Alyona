extends KinematicBody2D

const EXPLOSION = preload("res://explosion.tscn")
const FIREBALL = preload("res://fireball.tscn")

const MAXSPEED = 60
const GRAVITY = 20
const MAXFALLSPEED = 200
const UP = Vector2(0,-1)
const ACCEL = 8

var motion = Vector2()

var fire_cooldown = 2
var fire_counter = 1

var health = 1

func _ready():
	Global.num_alyonas += 1
	$Sprite.frame = 0

func _physics_process(delta):
	if !Global.dialogue_playing:
		if health <= 0 or self.position.y >= 400:
			if health <= 0 and Global.current_player_health < Global.MAX_PLAYER_HEALTH:  
				Global.current_player_health += 2
			queue_free()
			Global.num_alyonas -= 1
	
		fire_counter += 1 * delta
		
		motion.y += GRAVITY
		if motion.y > MAXFALLSPEED:
			motion.y = MAXFALLSPEED
		
		motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
		
		if fire_counter >= fire_cooldown:
			fire_counter = 0
			fire()
		elif self.position.x > Global.player_body.position.x:
			$Sprite.flip_h = true
			$Collision.position.x = -6
			$Area2D/Hurtbox.position.x = -6
			motion.x -= ACCEL
		elif self.position.x < Global.player_body.position.x:
			$Sprite.flip_h = false
			$Collision.position.x = 1
			$Area2D/Hurtbox.position.x = 1
			motion.x += ACCEL
		motion = move_and_slide(motion, UP)
	
func _on_Area2D_body_entered(body):
	queue_free()
	Global.num_alyonas -= 1
	var explosion = EXPLOSION.instance()
	get_parent().add_child(explosion)
	explosion.global_position = global_position
	
func fire():
	var fireball = FIREBALL.instance()
	
	get_parent().add_child(fireball)
	fireball.position = self.position
	
	if $Sprite.flip_h == true: 
		fireball.velocity = Vector2(-1, 0) 
		fireball.position.x -= 14
	else:
		fireball.position.x += 10
