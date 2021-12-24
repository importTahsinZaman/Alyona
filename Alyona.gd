extends KinematicBody2D

const EXPLOSION = preload("res://explosion.tscn")
const FIREBALL = preload("res://fireball.tscn")

const MAXSPEED = 80
const GRAVITY = 20
const MAXFALLSPEED = 200
const UP = Vector2(0,-1)
const ACCEL = 10

var motion = Vector2()

var fire_cooldown = 2
var fire_counter = 1

func _ready():
	$Sprite.frame = 5

func _physics_process(delta):
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
		motion.x -= ACCEL
	elif self.position.x < Global.player_body.position.x:
		$Sprite.flip_h = false
		motion.x += ACCEL
	motion = move_and_slide(motion, UP)
	
func _on_Area2D_body_entered(body):
	queue_free()
	var explosion = EXPLOSION.instance()
	get_parent().add_child(explosion)
	explosion.global_position = global_position
	
func fire():
	var fireball = FIREBALL.instance()
	
	get_parent().add_child(fireball)
	fireball.position = $Position2D.global_position
	if $Sprite.flip_h == true: 
		fireball.velocity = Vector2(-1, 0) 
