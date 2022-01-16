extends KinematicBody2D

const ALYONA = preload("res://Alyona.tscn")
const TWOKILLDIALOGUE = preload("res://TwoKillDialogue.tscn")

var rng = RandomNumberGenerator.new()

var MAXSPEED = 80 #80
const GRAVITY = 20
const MAXFALLSPEED = 200
const UP = Vector2(0,-1)
var ACCEL = 8 #8
const JUMPFORCE = 500

var jump_cooldown = 1.8
var jump_timer = 4

var motion = Vector2()

var attacking = false

func _ready():
	get_node("Global").connect("spawn_alyona", self, "spawn_alyona")
	if !Global.first_kill: 
		self.position.x = 200
		self.position.y = 181
	$HitBox/CollisionShape2D.disabled = true
	if Global.return_to_town: 
		self.position = Global.last_player_location
	if Global.return_from_death:
		get_tree().change_scene("res://World.tscn")
		if Global.spoken_with_rask:
			get_parent().get_node("Raskolnikov House").local_change_house()
		elif CheckpointTracker.police_door:
			get_parent().get_node("PoliceStation").local_change_house()
		elif CheckpointTracker.palais_door:
			get_parent().get_node("Palais De Cristal").local_change_house()
		elif CheckpointTracker.marm_door:
			get_parent().get_node("Marmeladov House").local_change_house()
		elif CheckpointTracker.raz_door:
			get_parent().get_node("Razumihin's House").local_change_house()
		else:
			get_parent().get_node("Alyona's House").local_change_house()
		#self.position = get_parent().get_node("Door").position - Vector2(8,0)
		Global.return_from_death = false
	if Global.return_from_dialogue:
		self.position = Global.player_dialogue_pos
		Global.return_from_dialogue = false
	Global.player_body = self
	
	
func _physics_process(delta):
	if !is_on_floor():
		ACCEL = 16
		MAXSPEED = 100
	else:
		ACCEL = 8
		MAXSPEED = 80
	if !Global.dialogue_playing:
		if Global.current_player_health <= 0:
			get_tree().change_scene("res://DeathScreen.tscn")
		
		motion.y += GRAVITY
		if motion.y > MAXFALLSPEED:
			motion.y = MAXFALLSPEED
		
		motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
		
		if $AnimatedSprite.animation == "attack" and $AnimatedSprite.get_frame() == 3:
			$HitBox/CollisionShape2D.disabled = false
		else:
			$HitBox/CollisionShape2D.disabled = true
		
		jump_timer += 1*delta
		
		if Input.is_action_pressed("ui_up") and !attacking and jump_timer >= jump_cooldown:
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
	if body.health - 1 == 0:
		Global.kill_counter += 1
		if Global.kill_counter == 1:
			Global.first_kill = true
			var two_kill_dialogue = TWOKILLDIALOGUE.instance()
			get_parent().add_child(two_kill_dialogue)
			two_kill_dialogue.rect_position.x = $Camera2D.position.x - 10
			two_kill_dialogue.rect_position.y = $Camera2D.position.y + 50
	body.health -= 1


func spawn_alyona():
	if !Global.dialogue_playing:
		var rand_num = rng.randf_range(0, 5)
		for i in range(rand_num):
			var alyona = ALYONA.instance()
			get_parent().add_child(alyona)
			get_parent().move_child(alyona, 8)
			alyona.position.y = self.position.y
			var rand_x = 0
			if !Global.return_to_town:
				rand_x = rng.randf_range(0+ 15, Global.camera_clamps.y - 15)
			else:
				rand_x = rng.randf_range(self.position.x - 200, self.position.x + 200)
			alyona.position.x = rand_x
