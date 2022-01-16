extends Node2D

const CHECKPOINT = preload("res://Checkpoint.tscn")

func _ready():
	if CheckpointTracker.raz_spoken and CheckpointTracker.dounia_spoken: CheckpointTracker.raz_door = true
	if CheckpointTracker.marm_spoken: CheckpointTracker.marm_door = true
	if CheckpointTracker.zam_spoken: CheckpointTracker.palais_door = true
	if CheckpointTracker.porf_spoken: CheckpointTracker.police_door = true
	
	CheckpointTracker.house_doors = [CheckpointTracker.raz_door, CheckpointTracker.marm_door, CheckpointTracker.palais_door, CheckpointTracker.police_door, CheckpointTracker.rask_door]
	
	for i in range(5):
		if CheckpointTracker.house_doors[i] == false:
			var checkpoint = CHECKPOINT.instance()
			get_parent().add_child(checkpoint)
			checkpoint.position = CheckpointTracker.house_checkpoints[i]
	if Global.spoken_with_rask:
		get_tree().change_scene("res://FinalArena.tscn")
