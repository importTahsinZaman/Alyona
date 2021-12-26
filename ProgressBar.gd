extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = Global.MAX_PLAYER_HEALTH

func _physics_process(delta):
	value = Global.current_player_health
