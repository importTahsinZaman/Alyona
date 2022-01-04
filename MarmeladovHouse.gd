extends Node2D

const CHECKPOINT = preload("res://Checkpoint.tscn")

func _ready():
	if !CheckpointTracker.marm_spoken:
		var checkpoint = CHECKPOINT.instance()
		add_child(checkpoint)
		checkpoint.position = $Marmeladov.position + Vector2(2, 0)
