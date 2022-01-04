extends Node2D

const CHECKPOINT = preload("res://Checkpoint.tscn")

func _ready():
	if !CheckpointTracker.raz_spoken:
		var checkpoint = CHECKPOINT.instance()
		add_child(checkpoint)
		checkpoint.position = $Razumihin.position
		checkpoint.position.x = $Razumihin.position.x + 3
	if !CheckpointTracker.dounia_spoken:
		var checkpoint = CHECKPOINT.instance()
		add_child(checkpoint)
		checkpoint.position = $Dounia.position
		checkpoint.position.x = $Dounia.position.x
