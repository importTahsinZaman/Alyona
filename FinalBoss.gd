extends KinematicBody2D

const MAXSPEED = 50
const ACCEL = 7
const UP = Vector2(0,-1)
var motion = Vector2()

var player_in_left = false
var player_in_right = false

var attacking = false
var can_attack = true

func _ready():
	pass

func _physics_process(delta):
	if attacking:
		$AnimatedSprite.play("AxeAttack")
		if $AnimatedSprite.animation == "AxeAttack" and $AnimatedSprite.get_frame() == 5:
			$Hitbox/CollisionShape2D.disabled = false
		else:
			$Hitbox/CollisionShape2D.disabled = true
	else:
		if can_attack == false:
			$AnimatedSprite.play("Idle")
		elif player_in_left or player_in_right:
			if player_in_right:
				 $Hitbox/CollisionShape2D.position.x = 38
				 $AnimatedSprite.flip_h = false
			elif player_in_left:
				$Hitbox/CollisionShape2D.position.x = -38
				$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("AxeAttack")
			attacking = true
		else:
			motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
			if self.position.x > Global.player_body.position.x:
				$AnimatedSprite.flip_h = true
				motion.x -= ACCEL
			elif self.position.x < Global.player_body.position.x:
				$AnimatedSprite.flip_h = false
				motion.x += ACCEL
			$AnimatedSprite.play("Run")
			motion = move_and_slide(motion, UP)


func _on_DetectBoxRight_body_entered(body):player_in_right = true
func _on_DetectBoxRight_body_exited(body): player_in_right = false
func _on_DetectBoxLeft_body_entered(body): player_in_left = true
func _on_DetectBoxLeft_body_exited(body): player_in_left = false

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "AxeAttack":
		$Hitbox/CollisionShape2D.disabled = true
		attacking = false
		can_attack = false


func _on_Timer_timeout(): 
	can_attack = true


func _on_Hitbox_body_entered(body):
	Global.current_player_health -= 1
