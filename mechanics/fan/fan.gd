extends Mechanics

@export var fan_on:bool = false
@export var fan_range:int = 3

var tilemap
var direction

var self_pos
var self_pos_in_map
var left_one
var right_one

func _ready():
	basic_setup()
	tilemap = Global.current_tilemap
	check()

func check():
	self_pos = self.get_global_position()
	self_pos_in_map = tilemap.local_to_map(self_pos)
	left_one = Vector2i(self_pos_in_map.x - 1,self_pos_in_map.y)
	right_one = Vector2(self_pos_in_map.x + 1,self_pos_in_map.y)
	if tilemap.get_cell_tile_data(0,left_one) == null and tilemap.get_cell_tile_data(0,right_one) == null:
		self.queue_free()
		Global.reset_build_menu()

func _process(delta):
	if fan_on:
		pass

