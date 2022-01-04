extends Node2D

const CHECKPOINT = preload("res://Checkpoint.tscn")

func _ready():
	if !CheckpointTracker.zam_spoken:
		var checkpoint = CHECKPOINT.instance()
		add_child(checkpoint)
		checkpoint.position = $Zametov.position + Vector2(0, -4)
