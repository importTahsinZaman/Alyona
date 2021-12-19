extends Camera2D

func _ready():
	self.limit_left = Global.camera_clamps.x
	self.limit_right = Global.camera_clamps.y
