extends TileMap

var canvas_layer
var mouse

var indicator = preload("res://gui/tile_selector/tile_selector.tscn")
var build_menu = preload("res://gui/build_menu/build_menu.tscn")

var mouse_pos:Vector2
var tile_pos:Vector2i
var previous_tile_pos:Vector2i

var locked_tile_pos:Vector2i
var is_locked = false

func _ready():
	Global.current_tilemap = self
	pass

func _process(delta):
	if !is_locked:
		tile_pos = local_to_map(get_global_mouse_position())
		
		if tile_pos != previous_tile_pos or previous_tile_pos == null:
			erase_cell(1,previous_tile_pos)
			set_cell(1,tile_pos,2,Vector2i(0,0),1)
		
		previous_tile_pos = tile_pos
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and is_locked == false:
			is_locked = true
			locked_tile_pos = tile_pos
			var ins = build_menu.instantiate()
			canvas_layer.add_child(ins)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			mouse.hide()


func place_block(vect:Vector2i):
	set_cell(0,tile_pos,0,vect,0)
	release()

func release():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	mouse.show()
	is_locked = false
