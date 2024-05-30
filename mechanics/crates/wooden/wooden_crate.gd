extends Crate


var tilemap 

func _ready():
	basic_setup()
	tilemap = Global.current_tilemap

func _input(event):
	if Input.is_action_pressed("click") and Global.player.current_hammer == 2:
		if tilemap.tile_pos ==  tilemap.local_to_map(get_global_position()):
			self.queue_free()
