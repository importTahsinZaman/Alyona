extends Camera2D

func _ready(in_town = false):
	self.limit_left = Global.camera_clamps.x
	self.limit_right = Global.camera_clamps.y
	self.limit_top = Global.camera_clamps.z
