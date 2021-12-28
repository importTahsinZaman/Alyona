extends Camera2D

func _ready(in_town = false):
	self.limit_left = Global.camera_clamps.x
	self.limit_right = Global.camera_clamps.y
	self.limit_top = Global.camera_clamps.z
	self.zoom.x = Global.camera_zoom_position[0]
	self.zoom.y = Global.camera_zoom_position[1]
	self.position.x = Global.camera_zoom_position[2]
	self.position.y = Global.camera_zoom_position[3]
