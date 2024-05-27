extends TileMap

var indicator = preload("res://gui/tile_selector/tile_selector.tscn")

var mouse_pos:Vector2
var tile_pos:Vector2i
var previous_tile_pos:Vector2i
# Called when the node enters the scene tree for the first time.
func _ready():
	#set_cell(0,Vector2i(0,0),2,Vector2i(0,0),1)
	#set_cell(0,Vector2i(0,0),0,Vector2i(1,1),0)
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#mouse_pos = get_global_mouse_position()
	#var tile_x = int(mouse_pos.x / 16)
	#var tile_y = int(mouse_pos.y / 16)
	#tile_pos = Vector2i(tile_x,tile_y)
	
	tile_pos = local_to_map(get_global_mouse_position())
	
	if tile_pos != previous_tile_pos or previous_tile_pos == null:
		erase_cell(1,previous_tile_pos)
		set_cell(1,tile_pos,2,Vector2i(0,0),1)
	
	previous_tile_pos = tile_pos
	
	#
	#print(get_cell_source_id(0,tile))
	#print(get_cell_atlas_coords(0,tile))
	#print(get_cell_alternative_tile(0,tile))
	
