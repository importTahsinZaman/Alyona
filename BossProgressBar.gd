extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.max_value = Global.MAX_BOSS_HEALTH

func _physics_process(delta):
	self.value = Global.current_boss_health
