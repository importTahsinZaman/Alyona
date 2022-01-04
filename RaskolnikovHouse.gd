extends Node2D

const CHECKPOINT = preload("res://Checkpoint.tscn")

func _ready():
	if !CheckpointTracker.raskol_spoken:
		var checkpoint = CHECKPOINT.instance()
		add_child(checkpoint)
		checkpoint.position = $Raskolnikov.position + Vector2(2, 0)
	if !CheckpointTracker.sonia_spoken:
		var checkpoint = CHECKPOINT.instance()
		add_child(checkpoint)
		checkpoint.position = $Sonia.position + Vector2(2, 0)
