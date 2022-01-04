extends Node2D

const CHECKPOINT = preload("res://Checkpoint.tscn")

func _ready():
	if !CheckpointTracker.porf_spoken:
		var checkpoint = CHECKPOINT.instance()
		add_child(checkpoint)
		checkpoint.position = $Porfiry.position + Vector2(2, -2)
